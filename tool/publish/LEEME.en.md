# Exporting the public repository

[Español](LEEME.md)

Requirements: Git, a POSIX shell (Git Bash on Windows or `sh` on macOS), and
Python 3.9 or later, with no additional packages. From the repository root:

```sh
sh tool/publish/export_public.sh HEAD /empty/path/ink-lab-public
```

The destination must be outside the source repository and empty, including
hidden files. Its path must not contain symlinks. Missing directories are created.
The source repository is unchanged. The exporter makes no network calls.

To override the interpreter and public identity:

```sh
PUBLIC_PYTHON=python3 PUBLIC_AUTHOR_NAME='Your name' \
PUBLIC_AUTHOR_EMAIL='public@example.org' \
sh tool/publish/export_public.sh COMMIT /empty/path/ink-lab-public
```

The interpreter defaults to `python` if available, otherwise `python3`. In Git
Bash, use Windows paths with `/` for a fully qualified `PUBLIC_PYTHON` executable.
Both author and committer default to Daniel Mont Ferrandiz `<dev@mainshai.com>`.
The new `main` branch has one commit, titled “Initial public release of Ink Lab” (commits in the public repo are in English),
without remotes, tags or private history. Nothing is pushed.

## Selection policy

The checked-out exporter's `allowlist.txt` defines the policy: use the reviewed
version for your candidate. Each line is a POSIX relative path or a Python
`fnmatch` pattern (`*` also matches `/`); lines starting with `#` are comments.
The initial policy lists **individual reviewed files**, inventoried with
`git ls-files`. New files require an explicit addition. In particular, once they
exist and have been reviewed, add by hand the files of `lib/l10n/` (ARB and
generated), the images of `docs/readme/` and the catalogue generators of `tools/`.

The exporter resolves the commit, inventories it with `git ls-tree`, then streams
`git archive`. Only selected entries from that commit are written; worktree files,
ignored files and uncommitted changes are never copied. Selected symlinks and
submodules fail validation, as do missing entries caused by `export-ignore`. The
commit must contain `pubspec.yaml` at its root.

Included: the Flutter code, the Android and iOS native projects, tests, the
catalogues and fonts in `assets/`, CI, READMEs, licences, security and privacy
documents, the legal web pages and the technical contribution contracts
(`docs/ARCHITECTURE.md`, `docs/RELEASING.md`, `docs/privacy*.md`, `docs/legal/`).
Public contribution rules are in `CONTRIBUTING.md` and `CONTRIBUTING.es.md`.

Excluded:

| Files or group | Reason |
|---|---|
| `.mcp.json`, `.claude/`, `.shots/`, `.handoff.md`, `.plan-gratis.md`, `CLAUDE.md`, `AGENTS.md` | Internal configuration and agent instructions |
| `docs/HANDOFF.md` | Internal handoff between work sessions |
| `docs/DESIGN_SPEC.md`, `docs/design-mockups/` | Internal design specification and mockups; some code comments still cite them |
| `docs/release/` (`STORE_RELEASE.md`, `MAC_IOS_SETUP.md`) | Internal store plan, pending decisions and Mac steps; some code comments still cite them |
| `docs/ROADMAP.md` | Internal schedule, out of date; refresh it before publishing |
| APK/AAB, keystores, `key.properties`, `.env*` | Not public sources; keys never go in the repository |
| Logs, QA screenshots, keys and personal backups | Neither public sources nor test data |
| `gradlew` and `gradle-wrapper.jar` | Not versioned; Flutter 3.47.7 restores the wrapper when building Android |

Direct `./gradlew` use requires restoring the wrapper first; use `flutter build apk`
as the build entry point. Dart tests do not read excluded documents. The public
repository's CI (`.github/workflows/ci.yml`) runs `flutter analyze`,
`flutter test` and `web/legal/test_legal.py`.

## Validation and limits

Names and bytes are checked before creating Git: personal Windows/macOS paths,
the local development identifier, private files, caches, logs, APKs, AABs, `.env*`,
`*.env`, `key.properties`, `local.properties`, keystores, private keys (`.p8`,
`.p12`, `.pem`, `.key`, `.mobileprovision`), `google-services.json`,
`GoogleService-Info.plist` and `secrets.*`. Private key markers,
GitHub/OpenAI tokens and AWS access keys are rejected, as well as Google API
keys (`AIza…`), live Stripe keys (`sk_live…`), Slack tokens (`xox…`), RevenueCat
keys (`appl…`, `goog…`), JWTs (three base64url segments separated by dots, the
first one starts with `eyJ…` and the payload may be `e30`) and
`storePassword`/`keyPassword` assignments in JSON, YAML, Gradle or Groovy.
Assigning the password from the Gradle variables `releaseStorePassword` and
`releaseKeyPassword` (read from `key.properties` or the environment) is not a
value and is accepted, as is reading it with
`keyProperties.getProperty("storePassword")`.

No `@gmail.com` address is accepted, nor the author email of the source
repository. A domain that only begins with `gmail.com` is not a Gmail address
and is accepted. That email is read at runtime with `git config user.email` and is
never written in the code: the exporter adapts to whoever signs, without
leaving the address anywhere.

The effective attributes of every exported file are checked
(`git check-attr export-subst export-ignore`), the ones Git applies when it
archives: the `.gitattributes` of the commit plus
`$GIT_DIR/info/attributes`, which is not versioned. The export fails only when
the attribute is active; a disabled one (`-export-ignore`) or a commented line
changes nothing.

The exported bytes are compared with the blob of the commit. Only the line
ending difference that Git applies with the `eol` attribute is allowed; any
other rewrite, such as the one of `export-subst`, fails the export.

Binaries are only accepted under `assets/` (fonts), `test/`, `docs/readme/`, or
native PNG icons (`android/app/src/main/res/` and `ios/Runner/Assets.xcassets/`).

The local identifier is also rejected inside public GitHub or GitHub Pages URLs.
There is no implicit exception for links (the public account `dferrandizmont` is
accepted, the local user name is not): a candidate retaining that identity in its
README or website fails export. Resolve this policy explicitly before approving
the first public copy.

Files are read back before creating the commit in a temporary sibling directory.
The resulting Git repository must track exactly the selection, with one commit,
no remotes and no pending changes. A validation failure leaves an empty destination
and removes only this invocation's temporary staging directory. A nonempty
destination is never emptied or overwritten. Errors do not print suspected
secret values or source lines.

Pattern checks do not establish licensing, data provenance, image metadata
privacy or the absolute absence of secrets. The lead must review the exact tree,
images and final identity before any publication. Publishing is a separate step.

## Reproduce validation

```sh
python -B tool/publish/test_export_public.py
python -B tool/publish/test_update_public.py
sh tool/publish/export_public.sh HEAD /empty/path/ink-lab-public
cd /empty/path/ink-lab-public
python -B web/legal/test_legal.py
flutter pub get
flutter analyze
flutter test
```

All candidate changes must be committed: exporting with a dirty worktree does
**not** include those changes. If an agent cannot commit its branch, the receiving
lead must commit and export `HEAD` again before approving the final candidate.

## Creating and updating the public repository

The exporter always creates a new single-commit repository. For the first
publication of `dferrandizmont/ink-lab`:

1. Export `HEAD` to an empty folder and check the result. If a check fails, fix
   it in the private repository and export again.
2. Review the tree, the images and the identity. Create the empty public
   repository on GitHub (with the owner's go-ahead), add the remote and run
   `git push -u origin main`.
3. The website and policy are published at https://inklab.mainshai.com from `web/`; the `gh-pages` branch only
   redirects (`web/legal/LEEME.md`).

To publish later changes while keeping the public history, use the update mode
(it uses no network and does not push):

1. Prepare the commit's `CHANGELOG.md`: a `## X.Y.Z · date` section with the version's
   bullets (the "Unreleased" section is renamed when you publish). Its bullets become the
   public commit body.
2. Clone (or refresh with `git pull --ff-only`) the public repository in a folder
   outside this repository: `git clone https://github.com/dferrandizmont/ink-lab.git ../ink-lab-public`.
3. With the candidate already committed (`HEAD` or a specific commit) run:
   `sh tool/publish/update_public.sh HEAD ../ink-lab-public "0.4.0"`.
   The script exports the allowlisted tree of the commit with **the same scanners** as
   `export_public.sh`, replaces the clone's tree (keeping `.git`) and creates **one single
   commit** `Ink Lab 0.4.0` with the public identity (`PUBLIC_AUTHOR_NAME` and
   `PUBLIC_AUTHOR_EMAIL` override it, as in the export) and the changelog bullets as body.
   It refuses if the clone has local changes or ignored files, if `origin` (or any
   remote) is not `github.com/dferrandizmont/ink-lab`, if it is behind `origin/main`, if
   HEAD is detached, if the changelog has no such version, or if nothing changed. On any
   failure the clone is left as it was.
4. The script also creates the annotated tag `vX.Y.Z` with the public identity (an existing
   tag is left where it is). Review `git show --stat HEAD` in the clone and, with the owner's
   go-ahead, `git push origin main vX.Y.Z`.

Tags in the private repository carry the public identity too, never the Gmail address:
`git -c user.name="Daniel Mont Ferrandiz" -c user.email=dev@mainshai.com tag -a vX.Y.Z -m "Ink Lab X.Y.Z"`.

Public releases carry the APKs signed with the upload key (`docs/RELEASING.md`), with
`SHA256SUMS.txt` and the certificate SHA-256 fingerprint in the notes, in Spanish and English.
