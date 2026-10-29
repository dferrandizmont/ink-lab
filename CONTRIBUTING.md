# Contributing to Ink Lab

English · [Español](CONTRIBUTING.es.md)

Ink Lab is free, with no accounts, ads or purchases. The Flutter code is at the
repository root (`lib/`, `test/`) and its structure is in
[ARCHITECTURE.md](docs/ARCHITECTURE.md). Describe the problem, the expected
behaviour and how you verified it. Discuss UI and scope changes in an issue
first. By taking part you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).

| I want to... | Do this |
|---|---|
| Report a bug | [Bug report issue](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Suggest a feature | [Feature request issue](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Fix a wrong colour, name or code | [Data fix issue](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Report a security problem | [SECURITY.md](SECURITY.md), never a public issue |
| Send code | Fork, branch and open a [pull request](.github/PULL_REQUEST_TEMPLATE.md) |

- `lib/core/` is **pure Dart**: no Flutter imports, no I/O and no platform
  channels. The UI does not compute colours or call the network; the AI advisors
  (`lib/ai/`) are optional and can always fall back to the local engine.
- Follow the lints in `analysis_options.yaml` (`flutter_lints`) and format with
  `dart format .`. Keep changes small and focused, and test every logic change.
- The marker datasets (`assets/data/`) are **generated** files: do not hand-edit
  them. Open a data fix issue with the brand, the code, the current value, the
  correct one and a public source; a photo of the physical swatch helps. To add
  a brand or a set, discuss it in an issue first.
- Do not include logos, product photographs, packaging or colour cards from any
  brand: only codes, names, hex values and set membership
  ([NOTICE.md](NOTICE.md)).
- Do not attach keys or personal data. Reproduce problems with test data, and
  never paste a real backup or an API key.
- Keep commit messages short and imperative, with an optional prefix
  (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`).

With Flutter **3.47.7**, from the repository root:

```sh
flutter pub get
flutter analyze
flutter test
```

That is what CI runs on every pull request. Include the commands and results in
your PR, and a screenshot for UI changes. If you change the privacy policy,
update `docs/privacy.md`, `docs/legal/politica-privacidad.md` (and the English
versions) together and regenerate the web page with
`python -B web/legal/md2html.py`.

By contributing, you agree that your code is offered under the
[MIT License](LICENSE) and that your documentation and texts are offered under
[CC BY-SA 4.0](LICENSE-CONTENT.en.md).
