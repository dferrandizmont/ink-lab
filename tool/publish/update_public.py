"""Publish a new commit to a clone of the public repository. No network, no push."""

import importlib.util
import os
from pathlib import Path
import re
import shutil
import stat
import subprocess
import sys
import tarfile
import tempfile


HERE = Path(__file__).resolve().parent
_spec = importlib.util.spec_from_file_location('ink_lab_exporter', HERE / 'export_public.py')
exporter = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(exporter)

ROOT = exporter.ROOT
REMOTE = re.compile(
    r'^(?:https://(?:[^@/\s]+@)?github\.com/|git@github\.com:|ssh://git@github\.com/)'
    r'dferrandizmont/ink-lab(?:\.git)?/?$', re.I)
VERSION = re.compile(r'^\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.\-]+)?$')


def clone_env(clone):
    """The exporter's hardened Git environment, extended to the public clone."""
    env = dict(exporter.GIT_ENV)
    env['GIT_CONFIG_COUNT'] = '7'
    env['GIT_CONFIG_KEY_6'] = 'safe.directory'
    env['GIT_CONFIG_VALUE_6'] = str(clone)
    return env


def changelog_body(commit, version):
    """The bullets of the version's section in CHANGELOG.md, as the commit has it."""
    if not VERSION.match(version):
        raise ValueError('La versión debe tener la forma 1.2.3 (no "Unreleased")')
    try:
        text = exporter.git('show', f'{commit}:CHANGELOG.md').decode('utf-8')
    except subprocess.SubprocessError:
        raise ValueError('El commit no tiene CHANGELOG.md')
    heading = re.compile(r'^##\s+' + re.escape(version) + r'(?:\s|$)')
    section, inside = [], False
    for line in text.splitlines():
        if line.startswith('## '):
            if inside:
                break
            inside = bool(heading.match(line))
            continue
        if inside:
            section.append(line.rstrip())
    if not inside:
        raise ValueError(f'CHANGELOG.md no tiene una sección para {version}')
    bullets, current = [], None
    for line in section:
        if line.startswith('- '):
            current = [line]
            bullets.append(current)
        elif line.startswith('  ') and current is not None:
            current.append(line)
        else:
            current = None
    if not bullets:
        raise ValueError(f'La sección {version} de CHANGELOG.md no tiene viñetas')
    return '\n'.join('\n'.join(b) for b in bullets)


def check_clone(clone, env):
    if not (clone / '.git').exists():
        raise ValueError('La ruta no es la raíz de un clon de Git')
    top = Path(exporter.git('rev-parse', '--show-toplevel', cwd=clone, env=env).decode().strip()).resolve()
    if top != clone:
        raise ValueError('La ruta no es la raíz del clon')
    if clone == ROOT or ROOT in clone.parents or clone in ROOT.parents:
        raise ValueError('El clon debe estar fuera del repositorio de origen')
    remotes = exporter.git('remote', cwd=clone, env=env).decode().split()
    if not remotes:
        raise ValueError('El clon no tiene remoto')
    for name in remotes:
        urls = exporter.git('remote', 'get-url', '--all', name, cwd=clone, env=env).decode().split()
        if not urls or not all(REMOTE.match(url) for url in urls):
            raise ValueError('El remoto del clon no es github.com/dferrandizmont/ink-lab')
    try:
        exporter.git('rev-parse', '--verify', '-q', 'HEAD^{commit}', cwd=clone, env=env)
    except subprocess.SubprocessError:
        raise ValueError('El clon no tiene ningún commit')
    try:
        exporter.git('symbolic-ref', '-q', 'HEAD', cwd=clone, env=env)
    except subprocess.SubprocessError:
        raise ValueError('El clon está en HEAD desacoplado: cambia a una rama')
    if exporter.git('status', '--porcelain', '--ignored', '--untracked-files=all',
                    cwd=clone, env=env).strip():
        raise ValueError('El clon tiene cambios locales (o ficheros ignorados): déjalo limpio')
    tracking = subprocess.run(['git', 'rev-parse', '--verify', '-q', 'refs/remotes/origin/main^{commit}'],
                              cwd=clone, env=env, capture_output=True)
    if tracking.returncode == 0:
        behind = subprocess.run(['git', 'merge-base', '--is-ancestor', tracking.stdout.decode().strip(), 'HEAD'],
                                cwd=clone, env=env, capture_output=True)
        if behind.returncode != 0:
            raise ValueError('El clon no está al día con origin/main: haz git pull --ff-only')


def _writable(function, path, _info):
    os.chmod(path, stat.S_IWRITE)
    function(path)


def wipe(clone):
    """Remove the whole working tree except .git."""
    for child in clone.iterdir():
        if child.name == '.git':
            continue
        if child.is_dir() and not child.is_symlink():
            shutil.rmtree(child, onerror=_writable)
        else:
            try:
                child.unlink()
            except PermissionError:
                os.chmod(child, stat.S_IWRITE)
                child.unlink()


def update(revision, clone_path, version):
    commit = exporter.git('rev-parse', '--verify', '--end-of-options', revision + '^{commit}').decode().strip()
    exporter.load_private_emails()
    clone = Path(clone_path).absolute()
    if any(p.is_symlink() for p in (clone, *clone.parents)):
        raise ValueError('El clon o uno de sus padres es un enlace simbólico')
    clone = clone.resolve()
    if not clone.is_dir():
        raise ValueError('El clon no existe')
    env = clone_env(clone)
    check_clone(clone, env)
    author_name = os.environ.get('PUBLIC_AUTHOR_NAME', 'Daniel Mont Ferrandiz')
    author_email = os.environ.get('PUBLIC_AUTHOR_EMAIL', 'dev@mainshai.com')
    for value in (author_name, author_email):
        if not value.strip() or re.search(r'[<>\x00-\x1f\x7f]', value):
            raise ValueError('Identidad pública vacía o no válida')
        exporter.scan_bytes('identidad pública', value.encode('utf-8'))
    message = f'Ink Lab {version}\n\n{changelog_body(commit, version)}\n'
    exporter.scan_bytes('mensaje del commit', message.encode('utf-8'))
    selected = exporter.select_files(commit)
    before = exporter.git('rev-parse', 'HEAD', cwd=clone, env=env).decode().strip()
    with tempfile.TemporaryDirectory(prefix='.ink-lab-update-') as temporary:
        staging = Path(temporary)
        count = exporter.extract(commit, staging, selected)
        try:
            wipe(clone)
            for name in sorted(selected):
                target = clone / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes((staging / name).read_bytes())
            exporter.git('add', '--force', '--all', cwd=clone, env=env)
            for name, mode in selected.items():
                if mode == b'100755':
                    exporter.git('update-index', '--chmod=+x', '--', name, cwd=clone, env=env)
            diff = subprocess.run(['git', 'diff', '--cached', '--quiet'], cwd=clone, env=env)
            if diff.returncode == 0:
                raise ValueError('Nada ha cambiado respecto al último commit del clon')
            identity = dict(env, GIT_AUTHOR_NAME=author_name, GIT_AUTHOR_EMAIL=author_email,
                            GIT_COMMITTER_NAME=author_name, GIT_COMMITTER_EMAIL=author_email)
            exporter.git('-c', 'commit.gpgSign=false', 'commit', '--quiet', '--no-verify',
                         '-m', message, cwd=clone, env=identity)
            tracked = set(exporter.git('ls-files', '-z', cwd=clone, env=env).decode().rstrip('\0').split('\0'))
            if tracked != set(selected):
                raise ValueError('El árbol del commit no coincide con la selección')
            if exporter.git('status', '--porcelain', '--untracked-files=all', cwd=clone, env=env).strip():
                raise ValueError('El clon tiene cambios sin confirmar tras el commit')
            if exporter.git('rev-parse', 'HEAD^', cwd=clone, env=env).decode().strip() != before:
                raise ValueError('El commit nuevo no cuelga del anterior')
            if exporter.git('rev-list', '--count', f'{before}..HEAD', cwd=clone, env=env).strip() != b'1':
                raise ValueError('No hay exactamente un commit nuevo')
        except BaseException:
            # Leave the clone exactly as it was.
            wipe(clone)
            exporter.git('reset', '--hard', '--quiet', before, cwd=clone, env=env)
            raise
    # The version tag carries the public identity too, never the git config of this machine.
    tag = f'v{version}'
    if exporter.git('tag', '--list', tag, cwd=clone, env=env).strip():
        tagged = f'la etiqueta {tag} ya existía y no se mueve'
    else:
        exporter.git('-c', 'tag.gpgSign=false', 'tag', '--annotate', '--message', f'Ink Lab {version}', tag,
                     cwd=clone, env=identity)
        tagged = f'etiqueta {tag} con la identidad pública'
    print(f'OK: {count} ficheros; rutas, secretos, prohibidos y binarios comprobados.')
    print(f'OK: un commit nuevo "Ink Lab {version}", identidad pública, {tagged}, sin push.')
    print(f'Origen: {commit}')
    print(f'Clon: {clone}')
    print(f'Siguiente paso: revisa git show --stat HEAD y haz git push origin main {tag} (con el sí del dueño).')


if __name__ == '__main__':
    try:
        if len(sys.argv) != 4:
            raise ValueError('Uso: update_public.sh <commit> <clon-del-repo-público> "<versión>"')
        update(sys.argv[1], sys.argv[2], sys.argv[3])
    except (ValueError, OSError, EOFError, subprocess.SubprocessError, tarfile.TarError) as error:
        print(f'ERROR: {error if not isinstance(error, subprocess.SubprocessError) else "operación Git fallida"}',
              file=sys.stderr)
        sys.exit(1)
