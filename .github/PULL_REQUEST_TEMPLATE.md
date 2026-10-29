<!--
Thanks for contributing! Keep the pull request focused: one change per PR is
much easier to review and to merge.
-->

## What does this PR do?

<!-- A short description of the change and the problem it solves. -->

Fixes #<!-- issue number -->

## Type of change

- [ ] Bug fix
- [ ] New feature
- [ ] Data change (marker colours, names, codes, sets)
- [ ] Refactor / internal cleanup
- [ ] Documentation
- [ ] CI / build

## How was it tested?

<!--
Describe what you ran and what you observed. Screenshots or recordings are
welcome for UI changes.
-->

- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Ran the app on a device / emulator
- [ ] Verified the change offline (no network)

## Checklist

- [ ] `flutter analyze` reports no issues.
- [ ] `flutter test` passes, and new/changed logic has tests.
- [ ] `dart format .` was run on the files I touched.
- [ ] Domain logic stays in `lib/core/` as pure Dart (no Flutter imports, no
      I/O, no platform channels).
- [ ] No new dependencies were added, or the reason is explained above.
- [ ] No secrets, API keys, keystores or personal data are included.
- [ ] No brand artwork or other trademarked material was added; only codes,
      names, hex values and set membership (see `NOTICE.md`).
- [ ] Documentation was updated when behaviour changed.

## Breaking changes

<!--
Does this change user-visible behaviour, stored data formats, or the backup
format? If yes, describe the migration.
-->

None.
