# Architecture

This document describes the layering of Ink Lab. It is the design contract for
the codebase: new code should follow the dependency direction and the rules
below.

## Principles

1. **The domain is pure Dart.** Colour theory, palette maths and the data
   models must not depend on Flutter, on the platform, or on I/O. That keeps
   the interesting logic fast to test and reusable from every other layer.
2. **Everything works offline.** The default path never needs the network, an
   account or a key.
3. **The AI layer is optional and replaceable.** A model is a suggestion
   source, not a dependency of the app.
4. **Data is data.** Marker datasets are generated files, loaded from assets,
   never hand-edited in the app.
5. **No telemetry.** There is no analytics layer and no crash reporting SDK.

## Layers

```text
┌───────────────────────────────────────────────────────────┐
│  ui/          screens, widgets, theme, navigation           │
├───────────────────────────────────────────────────────────┤
│  ai/          advisors: local engine | on-device | BYOK     │
├───────────────────────────────────────────────────────────┤
│  data/        repositories, asset loading, local storage    │
├───────────────────────────────────────────────────────────┤
│  core/        pure Dart: models, colour theory, palette     │
│               maths, suggestions, ideas engine             │
└───────────────────────────────────────────────────────────┘
        dependency direction: downwards only
```

### `lib/core/` — pure Dart domain logic

Contains the parts of the app that are interesting to reason about and to
test:

- **models**: marker colour, marker set, palette, saved palette, favourite,
  idea preset, brand scope;
- **colour theory**: RGB/HSL conversion, hue relationships, tonal ramps,
  contrast helpers;
- **palette generation**: turning a base colour into a set of harmony
  candidates (analogous, complementary, split-complementary, triadic,
  tetradic, monochromatic/tonal, and combinations of these), including
  candidate selection and ordering rules;
- **ideas engine**: the creative presets (technique guidance, challenge
  palettes) and the rules that turn a preset into a concrete suggestion;
- **validation**: whether a suggested colour exists in the active collection
  and in the markers the user owns.

Nothing in `core/` may import `package:flutter`, read files, or talk to a
platform channel. Anything that needs one of those belongs to a layer above.

### `lib/data/` — sources, repositories, persistence

- **dataset loading**: parses `assets/data/*.json` into the models from
  `core/`, with a stable, normalised internal representation (a global colour
  id such as `<brandId>:<code>` so that favourites and saved palettes are
  unambiguous across brands);
- **repositories**: read-only access to markers, per brand, with an in-memory
  cache;
- **local persistence**: preferences and user state (active brand, owned
  markers, favourites, saved palettes, AI settings) in the platform's private
  storage;
- **backup codec**: export/import of user data as a versioned, plain JSON
  text. It never contains the API key or any other secret, which live behind a
  separate secret store (Android Keystore / iOS Keychain).

The data layer is the only place that knows about assets, files and storage
mechanisms.

### `lib/ui/` — screens, widgets, theme

- Screens for the swatch browser, the palette builder, the Ideas tab and
  settings.
- Reusable widgets for a swatch tile, a palette row, a colour chip, an
  owned-marker picker, and so on.
- Theme: colours, typography, spacing and radius tokens shared by every
  screen.

The UI layer reads state and calls intents; it does not compute colours or
call the network. State management (provider/bloc/whatever the project
settles on) lives here, above `core` and `data`.

### `lib/ai/` — advisors

An **advisor** answers one question: "given this context, suggest palettes".
All advisors implement the same interface and return the same domain type, so
the UI can offer the action without caring which one is active.

```text
AiPaletteAdvisor
├── LocalPaletteAdvisor      # default; wraps core/ palette generation
├── OnDeviceAiAdvisor        # uses a local model exposed by the OS
└── OpenRouterAdvisor        # BYOK; user-supplied key and model
```

- **`LocalPaletteAdvisor`** is the default and the fallback. It is pure Dart
  and always available, with no configuration. If a remote advisor fails, is
  disabled, or has no key, the app falls back to it.
- **`OnDeviceAiAdvisor`** uses a model provided by the operating system, where
  one exists. The request stays on the device.
- **`OpenRouterAdvisor`** implements bring-your-own-key cloud AI. It is only
  reachable when the user has explicitly enabled it and supplied their own key.
  The key is read from local storage, sent to the provider the user selected,
  and is never proxied through or logged by the app. Responses are validated
  before they are used, and any colour code that is not part of the active
  collection is discarded.

Advisors must degrade gracefully: a timeout, a malformed response, an
unreachable provider or a rate limit falls back to the local advisor and
surfaces a plain-language message to the user.

### Request flow, end to end

```text
user picks a base colour
        │
        ▼
  ui/  (palette screen)
        │  intent: buildPalette(base, size, scope)
        ▼
  data/  (repository: markers of the active brand, owned markers)
        │  candidate colours for the active scope
        ▼
  ai/  (advisor chain: remote/on-device if enabled, else local)
        │  list of suggested palettes
        ▼
  core/ (validation: keep only codes that exist in the active scope)
        │
        ▼
  ui/  (render suggestions; user can save or export)
```

## Data flow and the datasets

- Datasets live in `assets/data/` and are **generated** by the scripts in
  `tools/` (to be published).
- The Ohuhu dataset stores the current and the legacy code/name for each
  colour plus the sets it belongs to; the DecoTime dataset stores the code,
  name, hex and set membership.
- Manual calibration of extracted colours lives with the generator, so a
  regeneration never silently reverts a correction.
- A stable, brand-scoped colour id (`<brandId>:<code>`) is used for
  favourites and saved palettes, so the two brands never collide.

## Testing strategy

- `lib/core/` is unit tested exhaustively: colour conversions, palette
  generation, validation and the ideas engine are pure functions and cheap to
  test.
- `lib/data/` is tested against fixture JSON, including malformed input.
- `lib/ai/` is tested with a fake HTTP client and a fake local model; the
  contract is the same for all three advisors.
- `lib/ui/` has widget tests for the main flows.

CI runs `flutter analyze` and `flutter test` on every push and pull request.

## Adding a new brand or marker set

1. Add or extend the dataset in `assets/data/` through the generator script.
2. Map it to the shared internal model in `lib/data/` — no brand-specific
   branches in `core/`.
3. Scope user state (favourites, saved palettes) by the brand id.
4. Only codes, names, hex values and set membership are added. No brand
   artwork, per [NOTICE.md](../NOTICE.md).
