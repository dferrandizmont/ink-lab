"""Tests for the update mode. All repositories live in temporary directories; no network."""


import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


HERE = Path(__file__).resolve().parent
PUBLIC_URL = 'https://github.com/dferrandizmont/ink-lab.git'
CHANGELOG = (
    '# Changelog\n\n## Unreleased\n\n- Pending thing.\n\n'
    '## 0.4.0 · 2026-11-01\n\nIntro paragraph that is not a bullet.\n\n'
    '- First change that is long\n  and wraps onto a second line.\n- Second change.\n\n'
    '## 0.3.1 · 2026-10-29\n\n- Old change.\n'
)


class UpdateTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='ink-lab-update-test-')
        self.addCleanup(self.temporary.cleanup)
        self.base = Path(self.temporary.name)
        self.source = self.base / 'source with spaces'
        (self.source / 'tool/publish').mkdir(parents=True)
        for name in ['export_public.py', 'update_public.py', 'update_public.sh']:
            shutil.copyfile(HERE / name, self.source / 'tool/publish' / name)
        (self.source / 'tool/publish/allowlist.txt').write_text(
            'lib/*\npubspec.yaml\nREADME.md\nCHANGELOG.md\n.gitattributes\n', encoding='utf-8')
        (self.source / 'lib').mkdir()
        (self.source / 'lib/a.txt').write_text('alpha\n', encoding='utf-8')
        (self.source / 'lib/old.txt').write_text('to be removed\n', encoding='utf-8')
        (self.source / 'pubspec.yaml').write_text('name: fixture\n', encoding='utf-8')
        (self.source / 'README.md').write_text('Public text\n', encoding='utf-8')
        (self.source / 'CHANGELOG.md').write_text(CHANGELOG, encoding='utf-8')
        (self.source / 'private.md').write_text('Excluded research\n', encoding='utf-8')
        self.env = dict(
            {k: v for k, v in os.environ.items() if not k.startswith('GIT_')},
            GIT_CONFIG_NOSYSTEM='1', GIT_CONFIG_GLOBAL=os.devnull,
            GIT_AUTHOR_NAME='Test', GIT_AUTHOR_EMAIL='test@example.org',
            GIT_COMMITTER_NAME='Test', GIT_COMMITTER_EMAIL='test@example.org')
        self.git('init', '--quiet', '--initial-branch=main', '--template=')
        self.git('config', 'user.email', 'autor@example.org')
        self.commit_source()
        # The public repository: first release exported with the exporter, then cloned.
        first = self.base / 'public-first'
        result = subprocess.run(
            [sys.executable, '-B', str(self.source / 'tool/publish/export_public.py'), 'HEAD', str(first)],
            env=dict(self.env, PUBLIC_AUTHOR_NAME='Daniel Mont Ferrandiz',
                     PUBLIC_AUTHOR_EMAIL='dev@mainshai.com'), capture_output=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.clone = self.base / 'public clone'
        self.git('clone', '--quiet', '--template=', str(first), str(self.clone), cwd=self.base)
        self.git('remote', 'set-url', 'origin', PUBLIC_URL, cwd=self.clone)
        self.git('config', 'user.email', 'clon@example.org', cwd=self.clone)

    def git(self, *args, cwd=None):
        return subprocess.check_output(['git', *args], cwd=cwd or self.source,
                                       env=self.env, stderr=subprocess.PIPE)

    def commit_source(self):
        self.git('add', '--all')
        self.git('-c', 'commit.gpgSign=false', 'commit', '--quiet', '-m', 'Private development')

    def change_source(self):
        (self.source / 'lib/a.txt').write_text('alpha two\n', encoding='utf-8')
        (self.source / 'lib/new.txt').write_text('brand new\n', encoding='utf-8')
        (self.source / 'lib/old.txt').unlink()
        self.commit_source()

    def run_update(self, version='0.4.0', revision='HEAD', clone=None, shell=False, **env):
        entry = self.source / 'tool/publish' / ('update_public.sh' if shell else 'update_public.py')
        command = ['sh'] if shell else [sys.executable, '-B']
        return subprocess.run(
            [*command, str(entry), revision, str(clone or self.clone), version],
            env=dict(self.env, PUBLIC_PYTHON=sys.executable, **env), capture_output=True)

    def head(self, cwd=None):
        return self.git('rev-parse', 'HEAD', cwd=cwd or self.clone).strip()

    def test_adds_one_commit_with_changelog_body_and_public_identity(self):
        self.change_source()
        before = self.head()
        (self.source / 'README.md').write_text('Uncommitted private edit\n', encoding='utf-8')
        result = self.run_update(shell=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git('rev-list', '--count', f'{before.decode()}..HEAD', cwd=self.clone).strip(), b'1')
        self.assertEqual(self.git('rev-list', '--count', 'HEAD', cwd=self.clone).strip(), b'2')
        self.assertEqual(self.git('rev-parse', 'HEAD^', cwd=self.clone).strip(), before)
        message = self.git('log', '-1', '--format=%B', cwd=self.clone).decode()
        self.assertEqual(
            message.strip(),
            'Ink Lab 0.4.0\n\n- First change that is long\n  and wraps onto a second line.\n- Second change.')
        identity = self.git('show', '-s', '--format=%an <%ae>|%cn <%ce>', cwd=self.clone).decode().strip()
        self.assertEqual(identity, 'Daniel Mont Ferrandiz <dev@mainshai.com>|Daniel Mont Ferrandiz <dev@mainshai.com>')
        tag = self.git('for-each-ref', 'refs/tags/v0.4.0',
                       '--format=%(objecttype)|%(taggername) %(taggeremail)|%(contents:subject)|%(*objectname)',
                       cwd=self.clone).decode().strip()
        self.assertEqual(tag, f'tag|Daniel Mont Ferrandiz <dev@mainshai.com>|Ink Lab 0.4.0|{self.head().decode()}')
        self.assertEqual((self.clone / 'lib/a.txt').read_text(), 'alpha two\n')
        self.assertEqual((self.clone / 'lib/new.txt').read_text(), 'brand new\n')
        self.assertFalse((self.clone / 'lib/old.txt').exists())
        self.assertFalse((self.clone / 'private.md').exists())
        self.assertEqual((self.clone / 'README.md').read_text(), 'Public text\n')
        self.assertEqual(self.git('status', '--porcelain', '--ignored', cwd=self.clone), b'')
        self.assertEqual(self.git('remote', cwd=self.clone).strip(), b'origin')
        self.assertIn(b'lib/new.txt', self.git('ls-files', cwd=self.clone))

    def test_an_existing_tag_is_not_moved(self):
        self.git('tag', 'v0.4.0', cwd=self.clone)
        tagged = self.git('rev-parse', 'v0.4.0', cwd=self.clone)
        self.change_source()
        result = self.run_update()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(b'ya exist', result.stdout)
        self.assertEqual(self.git('rev-parse', 'v0.4.0', cwd=self.clone), tagged)

    def test_public_history_is_preserved(self):
        self.change_source()
        first = self.head()
        self.assertEqual(self.run_update().returncode, 0)
        self.assertEqual(self.git('log', '--format=%s', cwd=self.clone).decode().split('\n')[:3],
                         ['Ink Lab 0.4.0', 'Initial public release of Ink Lab', ''])
        self.assertEqual(self.git('rev-parse', 'HEAD~1', cwd=self.clone).strip(), first)

    def test_uses_the_requested_commit_not_the_worktree(self):
        self.change_source()
        old = self.git('rev-parse', 'HEAD').decode().strip()
        (self.source / 'lib/a.txt').write_text('later\n', encoding='utf-8')
        self.commit_source()
        self.assertEqual(self.run_update(revision=old).returncode, 0)
        self.assertEqual((self.clone / 'lib/a.txt').read_text(), 'alpha two\n')

    def test_nothing_changed_is_refused_and_clone_untouched(self):
        before = self.head()
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(b'Nada ha cambiado', result.stderr)
        self.assertEqual(self.head(), before)
        self.assertEqual(self.git('status', '--porcelain', cwd=self.clone), b'')
        self.assertEqual((self.clone / 'lib/a.txt').read_text(), 'alpha\n')

    def test_local_changes_are_refused(self):
        self.change_source()
        for prepare in [lambda: (self.clone / 'README.md').write_text('edited\n', encoding='utf-8'),
                        lambda: (self.clone / 'extra.txt').write_text('new\n', encoding='utf-8')]:
            with self.subTest():
                prepare()
                result = self.run_update()
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(b'cambios locales', result.stderr)
                self.assertEqual(self.git('rev-list', '--count', 'HEAD', cwd=self.clone).strip(), b'1')
                self.git('checkout', '--', '.', cwd=self.clone)
                self.git('clean', '-fdq', cwd=self.clone)

    def test_staged_change_is_refused(self):
        self.change_source()
        (self.clone / 'README.md').write_text('staged\n', encoding='utf-8')
        self.git('add', 'README.md', cwd=self.clone)
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual((self.clone / 'README.md').read_text(), 'staged\n')

    def test_wrong_remote_is_refused(self):
        self.change_source()
        for url in ['https://github.com/someone/ink-lab.git', 'https://example.org/dferrandizmont/ink-lab.git',
                    'https://github.com/dferrandizmont/ink-lab-fork.git',
                    'https://github.com/dferrandizmont/cuadrante.git']:
            with self.subTest(url=url):
                self.git('remote', 'set-url', 'origin', url, cwd=self.clone)
                result = self.run_update()
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(b'remoto', result.stderr)
                self.assertEqual(self.git('rev-list', '--count', 'HEAD', cwd=self.clone).strip(), b'1')

    def test_accepted_remote_forms_and_missing_remote(self):
        for url in ['https://github.com/dferrandizmont/ink-lab', 'git@github.com:dferrandizmont/ink-lab.git',
                    'ssh://git@github.com/dferrandizmont/ink-lab.git']:
            with self.subTest(url=url):
                self.git('remote', 'set-url', 'origin', url, cwd=self.clone)
                self.change_source() if url.endswith('ink-lab') else None
                result = self.run_update()
                self.assertTrue(result.returncode == 0 or b'Nada ha cambiado' in result.stderr, result.stderr)
        self.git('remote', 'remove', 'origin', cwd=self.clone)
        self.assertNotEqual(self.run_update().returncode, 0)

    def test_second_remote_must_also_match(self):
        self.change_source()
        self.git('remote', 'add', 'other', 'https://example.org/x.git', cwd=self.clone)
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(b'remoto', result.stderr)

    def test_clone_behind_origin_is_refused(self):
        self.change_source()
        self.git('commit', '--quiet', '--allow-empty', '-m', 'Remote work', cwd=self.base / 'public-first')
        self.git('fetch', '--quiet', str(self.base / 'public-first'), 'main:refs/remotes/origin/main', cwd=self.clone)
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(b'al d', result.stderr)

    def test_changelog_errors(self):
        self.change_source()
        for version, expected in [('9.9.9', b'no tiene una secci'), ('Unreleased', b'1.2.3'), ('0.4', b'1.2.3'),
                                  ('0.4.0; rm', b'1.2.3')]:
            with self.subTest(version=version):
                result = self.run_update(version=version)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(expected, result.stderr)
                self.assertEqual(self.git('rev-list', '--count', 'HEAD', cwd=self.clone).strip(), b'1')

    def test_section_without_bullets_is_refused(self):
        (self.source / 'CHANGELOG.md').write_text('# C\n\n## 0.5.0\n\nJust prose.\n', encoding='utf-8')
        self.change_source()
        result = self.run_update(version='0.5.0')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(b'vi', result.stderr)

    def test_changelog_is_read_from_the_commit(self):
        self.change_source()
        (self.source / 'CHANGELOG.md').write_text('# C\n\n## 0.4.0\n\n- Uncommitted bullet.\n', encoding='utf-8')
        self.assertEqual(self.run_update().returncode, 0)
        message = self.git('log', '-1', '--format=%B', cwd=self.clone).decode()
        self.assertIn('Second change.', message)
        self.assertNotIn('Uncommitted', message)

    def test_scanner_failure_leaves_clone_untouched(self):
        (self.source / 'lib/a.txt').write_text('secret sk-' + 'abcdefghijklmnopqrstuvwxyz0123\n', encoding='utf-8')
        self.commit_source()
        before = self.head()
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(self.head(), before)
        self.assertEqual(self.git('status', '--porcelain', cwd=self.clone), b'')
        self.assertEqual((self.clone / 'lib/a.txt').read_text(), 'alpha\n')

    def test_private_email_in_changelog_is_refused(self):
        text = CHANGELOG.replace('- Second change.', '- Contact autor@example.org for details.')
        (self.source / 'CHANGELOG.md').write_text(text, encoding='utf-8')
        self.change_source()
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(self.git('rev-list', '--count', 'HEAD', cwd=self.clone).strip(), b'1')

    def test_hooks_and_clone_config_do_not_interfere(self):
        self.change_source()
        hooks = self.clone / '.git/hooks'
        hooks.mkdir(exist_ok=True)
        (hooks / 'pre-commit').write_text('#!/bin/sh\nexit 1\n', encoding='utf-8')
        os.chmod(hooks / 'pre-commit', 0o755)
        self.git('config', 'commit.gpgsign', 'true', cwd=self.clone)
        result = self.run_update()
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_invalid_arguments_destination_and_revision(self):
        self.change_source()
        self.assertEqual(subprocess.run(['sh', str(self.source / 'tool/publish/update_public.sh'), 'HEAD'],
                                        env=self.env, capture_output=True).returncode, 2)
        self.assertNotEqual(self.run_update(revision='no-such-ref').returncode, 0)
        self.assertNotEqual(self.run_update(clone=self.base / 'missing').returncode, 0)
        notgit = self.base / 'plain'
        notgit.mkdir()
        self.assertNotEqual(self.run_update(clone=notgit).returncode, 0)
        self.assertNotEqual(self.run_update(clone=self.source).returncode, 0)
        subdir = self.clone / 'lib'
        self.assertNotEqual(self.run_update(clone=subdir).returncode, 0)

    def test_detached_head_is_refused(self):
        self.change_source()
        self.git('checkout', '--quiet', '--detach', cwd=self.clone)
        result = self.run_update()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(b'desacoplado', result.stderr)

    def test_executable_bit_is_kept(self):
        script = self.source / 'lib/run.sh'
        script.write_text('#!/bin/sh\n', encoding='utf-8')
        self.git('add', 'lib/run.sh')
        self.git('update-index', '--chmod=+x', 'lib/run.sh')
        self.git('-c', 'commit.gpgSign=false', 'commit', '--quiet', '-m', 'Add script')
        self.assertEqual(self.run_update().returncode, 0)
        self.assertTrue(self.git('ls-files', '-s', 'lib/run.sh', cwd=self.clone).startswith(b'100755'))


if __name__ == '__main__':
    unittest.main()
