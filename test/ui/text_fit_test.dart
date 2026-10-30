import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/collection/loose_markers_page.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/onboarding/onboarding_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_photo_scene.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/palette/palette_type_picker.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_widgets.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/select_card.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../ai/ai_test_support.dart';
import '../ai/fake_on_device_platform.dart';
import '../support/l10n.dart';
import '../support/pill_shapes.dart';
import '../support/tap_targets.dart';
import '../support/truncation.dart';
import 'match/match_test_support.dart';
import 'palette/palette_test_support.dart' show markerColor;

// Regression test for text that does not fit. Spanish is ~30 % longer than
// English, so every page and main sheet is pumped in both languages on the
// narrowest supported phone (360 dp) and a Pixel 10 Pro (412 dp), at normal
// and 1.3x text.
//
// Rules, checked after every step:
//  * no text is truncated (ellipsis / clipped) unless its full text is in a
//    Tooltip (marker names in grid cells, model ids);
//  * a control label (segmented option, chip, button, nav label, row title
//    or trailing value, header) is exactly one line: it never wraps;
//  * no layout error (RenderFlex overflow);
//  * no control, card or field is a pill (one small radius scale);
//  * every tap target is at least 44 x 44.

const String _apiKey = 'sk-or-v1-abcdef0123456789abcdef0123456789';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

class _Env {
  _Env(this.locale, this.width, this.scale);
  final Locale locale;
  final double width;
  final double scale;

  AppLocalizations get t => lookupAppLocalizations(locale);
  String get tag => '${locale.languageCode} ${width.toInt()}dp x$scale';
}

void _size(WidgetTester tester, _Env env) {
  tester.view.physicalSize = Size(env.width, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Pumps [page] in a Material app at [env]'s size, language and text scale.
Future<AppScope> _pump(
  WidgetTester tester,
  _Env env,
  Widget page, {
  AiSettingsRepository? aiSettings,
  SecretStore? secrets,
  AiService? aiService,
}) async {
  _size(tester, env);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    aiSettings: aiSettings,
    secrets: secrets,
    aiService: aiService,
    child: MaterialApp(
      locale: env.locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(env.scale)),
        child: child!,
      ),
      home: Scaffold(body: page),
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// Whether the paragraph of [element] is a control label.
bool _isControlLabel(Element element, String text) {
  var control = false;
  element.visitAncestorElements((Element a) {
    final Widget w = a.widget;
    if (w is InkSegmented ||
        w is InkChip ||
        w is FilledButton ||
        w is OutlinedButton ||
        w is TextButton ||
        w is InkNavigationBar ||
        w is NavigationRail ||
        w is InkGroupHead ||
        w is SettingsSubhead) {
      control = true;
    } else if (w is SelectCard) {
      control = text == w.title;
    } else if (w is InkListRow) {
      control = text == w.label || (w.value != null && text == w.value);
    } else if (w is SettingsSwitchRow) {
      control = text == w.label;
    } else if (w is SettingsControlRow) {
      control = text == w.label;
    } else if (w is InkPageHeader) {
      control = text == w.title;
    } else if (w is InkDefinitionRow) {
      control = text == w.label.toUpperCase();
    } else if (w is InkSectionHeading) {
      control = text == w.title;
    } else if (w is PaletteChoiceField) {
      // The caps label and the current choice of the type and scene fields.
      control = true;
    } else if (w is Text &&
        w.key is ValueKey<String> &&
        _controlTextKeys.any(
          (String prefix) =>
              (w.key! as ValueKey<String>).value.startsWith(prefix),
        )) {
      // Names in the palette type and scene sheets.
      control = true;
    } else {
      return true;
    }
    return false;
  });
  return control;
}

/// Key prefixes of the names in the palette type and scene sheets.
const List<String> _controlTextKeys = <String>[
  'palette-type-title-',
  'palette-scene-name-',
];

/// How many lines [p] is laid out on (distinct tops of its text boxes).
int _lineCount(RenderParagraph p) {
  final int length = p.text.toPlainText().length;
  if (length == 0) return 0;
  return p
      .getBoxesForSelection(TextSelection(baseOffset: 0, extentOffset: length))
      .map((TextBox b) => b.top.round())
      .toSet()
      .length;
}

/// Problems found so far in the running test (collected so one run lists
/// every offender, not just the first).
final Set<String> _problems = <String>{};
String _tag = '';

String _oneLine(String s) => s.replaceAll('\n', ' ');

/// Records truncated text, wrapped control labels, pill shapes, small tap
/// targets and layout errors.
void _check(WidgetTester tester, String where) {
  final Object? error = tester.takeException();
  if (error != null) {
    final String first = error.toString().split('\n').first;
    _problems.add('$_tag layout error: $first  [$where]');
  }
  for (final String text in truncatedTexts(tester)) {
    _problems.add('$_tag truncated: "${_oneLine(text)}"  [$where]');
  }
  for (final String target in smallTapTargets(tester)) {
    _problems.add('$_tag small target: $target  [$where]');
  }
  for (final String pill in pillShapes(tester)) {
    _problems.add('$_tag pill: $pill  [$where]');
  }
  for (final Element e in find.byType(RichText).evaluate()) {
    final RenderObject? render = e.renderObject;
    if (render is! RenderParagraph || !render.hasSize) continue;
    if (!isShown(e)) continue;
    final String text = render.text.toPlainText();
    if (!_isControlLabel(e, text)) continue;
    if (_lineCount(render) > 1) {
      _problems.add('$_tag wrapped: "${_oneLine(text)}"  [$where]');
    }
  }
}

/// Asserts that every role label and paint-order line on screen is laid out
/// on a single line; returns how many there were.
int _expectSingleLines(WidgetTester tester, String scene) {
  final Finder lines = find.byWidgetPredicate(
    (Widget w) =>
        w is RoleLabel ||
        (w.key is ValueKey<String> &&
            (w.key! as ValueKey<String>).value.startsWith('palette-step-')),
  );
  var count = 0;
  for (final Element e in lines.evaluate()) {
    final Finder paragraph = find.descendant(
      of: find.byWidget(e.widget),
      matching: find.byType(RichText),
    );
    if (paragraph.evaluate().isEmpty) continue;
    final RenderParagraph p = tester.renderObject(paragraph.first);
    expect(
      _lineCount(p),
      1,
      reason: '$_tag "${p.text.toPlainText()}" wraps  [$scene]',
    );
    expect(p.didExceedMaxLines, isFalse);
    count++;
  }
  return count;
}

/// Asserts that every explanation in the palette type sheet is one line (at
/// normal text size; larger text may wrap them, they are paragraphs).
void _expectTypeDescriptionsOneLine(WidgetTester tester) {
  final Finder descriptions = find.byWidgetPredicate(
    (Widget w) =>
        w is Text &&
        w.key is ValueKey<String> &&
        (w.key! as ValueKey<String>).value.startsWith('palette-type-desc-'),
  );
  expect(descriptions, findsWidgets, reason: '$_tag type sheet descriptions');
  for (final Element e in descriptions.evaluate()) {
    final RenderParagraph p = tester.renderObject(
      find.descendant(
        of: find.byWidget(e.widget),
        matching: find.byType(RichText),
      ),
    );
    expect(
      _lineCount(p),
      1,
      reason: '$_tag type description "${p.text.toPlainText()}" wraps',
    );
  }
}

/// Checks the current screen, then every screen of the first [Scrollable].
Future<void> _scroll(
  WidgetTester tester,
  String where, {
  Finder? within,
}) async {
  await scrollThrough(
    tester,
    (within ?? find.byType(Scrollable)).first,
    (int step) => _check(tester, where),
  );
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder.first);
  await tester.pumpAndSettle();
  await tester.tap(finder.first);
  await tester.pumpAndSettle();
}

/// Closes the top route (sheet or dialog).
Future<void> _close(WidgetTester tester) async {
  final NavigatorState nav = tester.state(find.byType(Navigator).first);
  nav.pop();
  await tester.pumpAndSettle();
}

http.Client _catalog() => MockClient(
  (_) async => jsonResponse(<String, Object>{
    'data': <Object>[
      <String, Object>{
        'id': 'a:free',
        'name': 'Free A',
        'pricing': <String, String>{'prompt': '0', 'completion': '0'},
      },
      <String, Object>{
        'id': 'meta-llama/llama-3.3-70b-instruct-experimental-preview:free',
        'name': 'Llama 3.3 70B Instruct Experimental Preview (free)',
        'pricing': <String, String>{'prompt': '0', 'completion': '0'},
      },
      <String, Object>{
        'id': 'b',
        'name': 'Paid B',
        'pricing': <String, String>{'prompt': '1', 'completion': '1'},
      },
    ],
  }),
);

Future<AppScope> _pumpSettings(
  WidgetTester tester,
  _Env env, {
  required AiProvider provider,
  bool enabled = false,
  bool withKey = false,
  OnDeviceStatus onDevice = OnDeviceStatus.available,
}) async {
  final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
    InMemoryKeyValueStore(),
  );
  await repo.replace(
    AiSettings(
      enabled: enabled,
      provider: provider,
      textModel: 'meta-llama/llama-3.3-70b-instruct-experimental-preview:free',
      textFallbacks: const <String>['a:free', 'b'],
    ),
  );
  final InMemorySecretStore secrets = InMemorySecretStore(
    withKey ? <String, String>{openRouterApiKeyName: _apiKey} : null,
  );
  final AiService service = AiService(
    aiSettings: repo,
    secrets: secrets,
    clientFactory: _catalog,
    onDevice: FakeOnDevicePlatform(currentStatus: onDevice),
  );
  return _pump(
    tester,
    env,
    const SettingsPage(),
    aiSettings: repo,
    secrets: secrets,
    aiService: service,
  );
}

/// "Scenes > From a photo" at [env]: the scene sheet entry, the source sheet,
/// the "Your photo" field, the role lines and (with few markers) the note.
Future<void> _fromPhotoScenario(
  WidgetTester tester,
  _Env env, {
  required Set<String> owned,
  required bool expectNote,
}) async {
  final AppScope scope = await _pump(
    tester,
    env,
    PalettePage(
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      decoder: fixedDecoder(
        imageFromRgb(5, 1, <List<int>>[
          <int>[223, 62, 53],
          <int>[223, 62, 53],
          <int>[19, 144, 77],
          <int>[38, 79, 179],
          <int>[243, 207, 72],
        ]),
      ),
      photoExtractor: (SampledImage image) async =>
          extractPhotoColorSets(image.rgba, image.width, image.height),
    ),
  );
  await scope.settings.setCollection(
    AppSettings(ownedSetIds: const <String>{}, extraMarkerIds: owned),
  );
  await tester.pumpAndSettle();
  await _tap(tester, find.byKey(const ValueKey<String>('palette-type-field')));
  await _tap(
    tester,
    find.byKey(const ValueKey<String>('palette-scenario-toggle')),
  );
  await tester.drag(find.byType(Scrollable).first, const Offset(0, 9000));
  await tester.pumpAndSettle();
  await _tap(tester, find.byKey(const ValueKey<String>('palette-scene-field')));
  _check(tester, 'scene sheet with From a photo');
  if (env.scale == 1.0) _expectTypeDescriptionsOneLine(tester);
  await _tap(tester, find.byKey(const ValueKey<String>('palette-scene-photo')));
  _check(tester, 'photo source sheet');
  await _tap(
    tester,
    find.byKey(const ValueKey<String>('palette-photo-camera')),
  );
  _check(tester, 'photo palette');
  expect(
    find.byKey(const ValueKey<String>('palette-photo-thumb')),
    findsOneWidget,
    reason: '$_tag photo thumbnail',
  );
  expect(
    find.byKey(const ValueKey<String>('palette-photo-far-note')),
    expectNote ? findsOneWidget : findsNothing,
    reason: '$_tag far note',
  );
  final RenderParagraph name = tester.renderObject(
    find.byKey(const ValueKey<String>('palette-scene-value')),
  );
  expect(_lineCount(name), 1, reason: '$_tag "Your photo"');
  expect(name.didExceedMaxLines, isFalse);
  expect(
    find.text(env.t.paletteFromPhotoValue),
    findsWidgets,
    reason: '$_tag "Your photo" text',
  );
  await tester.drag(find.byType(Scrollable).first, const Offset(0, 9000));
  await tester.pumpAndSettle();
  var seen = 0;
  await scrollThrough(tester, find.byType(Scrollable).first, (_) {
    seen += _expectSingleLines(tester, 'photo palette');
    _check(tester, 'photo palette');
  });
  expect(seen, greaterThan(0), reason: '$_tag photo palette has rows');
}

typedef _Scenario = Future<void> Function(WidgetTester tester, _Env env);

final Map<String, _Scenario> _scenarios = <String, _Scenario>{
  'shell: five tabs and the bottom bar': (WidgetTester tester, _Env env) async {
    _size(tester, env);
    useDeviceLocales(tester, <Locale>[env.locale]);
    tester.platformDispatcher.textScaleFactorTestValue = env.scale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      AppScope.inMemory(markers: _markers(), child: const InkLabApp()),
    );
    await tester.pumpAndSettle();
    _check(tester, 'swatches tab');
    final Finder items = find.descendant(
      of: find.byType(InkNavigationBar),
      matching: find.byType(InkResponse),
    );
    expect(items, findsNWidgets(5));
    for (int i = 0; i < 5; i++) {
      await tester.tap(items.at(i));
      await tester.pumpAndSettle();
      _check(tester, 'tab $i');
    }
  },
  'swatches: page, filters sheet, detail sheet':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const SwatchesPage());
        _check(tester, 'swatches');
        await _tap(tester, find.textContaining(env.t.swatchesFilters));
        _check(tester, 'filters sheet');
        final Finder packs = find.text(env.t.swatchesAllPacks);
        if (packs.evaluate().isNotEmpty) {
          await _tap(tester, packs);
          _check(tester, 'filters sheet, packs open');
        }
        await _close(tester);
        await _scroll(tester, 'swatches');
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();
        await _tap(tester, find.text('B08'));
        _check(tester, 'swatch detail sheet');
        await _scroll(
          tester,
          'swatch detail sheet',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
      },
  'palette: base, harmonies, scenarios, save dialog':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const PalettePage());
        _check(tester, 'palette');
        await tester.enterText(
          find.byKey(const ValueKey<String>('palette-base-input')),
          'B08',
        );
        await tester.pumpAndSettle();
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        _check(tester, 'palette with base');
        // "Add to palette" from Swatches replaces the base: undo notice.
        addTearDown(() => paletteBaseDraft.value = null);
        paletteBaseDraft.value = markerColor('R16', '#f2a6a0');
        await tester.pumpAndSettle();
        _check(tester, 'palette undo notice');
        ScaffoldMessenger.of(tester.element(find.byType(PalettePage)))
            .removeCurrentSnackBar();
        await tester.pumpAndSettle();
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-pick-base')),
        );
        _check(tester, 'base picker');
        await _close(tester);
        await _scroll(tester, 'palette');
        await _tap(tester, find.byKey(const ValueKey<String>('palette-save')));
        _check(tester, 'save dialog');
        await _close(tester);
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 9000));
        await tester.pumpAndSettle();
        // The type sheet: every mode with its glyph and explanation.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-type-field')),
        );
        _check(tester, 'palette type sheet');
        if (env.scale == 1.0) _expectTypeDescriptionsOneLine(tester);
        await _scroll(
          tester,
          'palette type sheet',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-scenario-toggle')),
        );
        _check(tester, 'palette scenarios');
        await _scroll(tester, 'palette scenarios');
        // The scene sheet: every category and scene, then a search.
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 9000));
        await tester.pumpAndSettle();
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-scene-field')),
        );
        _check(tester, 'scene sheet');
        await _scroll(
          tester,
          'scene sheet',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
        await tester.enterText(
          find.byKey(const ValueKey<String>('palette-scene-search')),
          'piel',
        );
        await tester.pumpAndSettle();
        _check(tester, 'scene sheet search');
        await _close(tester);
        _check(tester, 'palette with a scene');
        // The longest type names, in the field itself.
        for (final String mode in <String>[
          'splitComplementary',
          'customPalette',
          'rectangle',
        ]) {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
          await _tap(
            tester,
            find.byKey(const ValueKey<String>('palette-type-field')),
          );
          await _tap(
            tester,
            find.byKey(ValueKey<String>('palette-mode-$mode')),
          );
          _check(tester, 'palette type $mode');
        }
      },
  'palette: scene rows, paint order and scene name on one line':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const PalettePage());
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-type-field')),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-scenario-toggle')),
        );
        // The longest scene name, then scenes whose roles are the longest
        // ones ("Amarillo mantequilla", "Azul marino profundo").
        for (final String id in <String>[
          'wildflowerMeadow',
          'bakery',
          'nauticalStripes',
        ]) {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
          await _tap(
            tester,
            find.byKey(const ValueKey<String>('palette-scene-field')),
          );
          await tester.enterText(
            find.byKey(const ValueKey<String>('palette-scene-search')),
            Scene.byId(id).nameFor(env.locale.languageCode),
          );
          await tester.pumpAndSettle();
          await _tap(tester, find.byKey(ValueKey<String>('palette-scene-$id')));
          _check(tester, 'scene $id');
          final Scene scene = Scene.byId(id);
          expect(
            find.text(env.t.scenarioLabel(scene)),
            findsWidgets,
            reason: '$_tag scene name of $id',
          );
          final RenderParagraph name = tester.renderObject(
            find.byKey(const ValueKey<String>('palette-scene-value')),
          );
          expect(_lineCount(name), 1, reason: '$_tag scene name of $id');
          expect(name.didExceedMaxLines, isFalse);

          // Every role label and every paint-order line, screen by screen
          // (the lists build lazily), is a single line.
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
          var seen = 0;
          await scrollThrough(tester, find.byType(Scrollable).first, (_) {
            seen += _expectSingleLines(tester, id);
          });
          expect(seen, greaterThan(0), reason: '$_tag $id has rows');
        }
      },
  'palette: AI result, report button and dialog':
      (WidgetTester tester, _Env env) async {
        final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
          InMemoryKeyValueStore(),
        );
        await repo.replace(
          AiSettings(
            enabled: true,
            provider: AiProvider.openRouter,
            textModel: 'model-a',
          ),
        );
        final InMemorySecretStore secrets = InMemorySecretStore(
          <String, String>{openRouterApiKeyName: _apiKey},
        );
        final AiService service = AiService(
          aiSettings: repo,
          secrets: secrets,
          // Echoes back the first candidates of the prompt as an AI palette.
          clientFactory: () => MockClient((http.Request request) async {
            final Map<String, dynamic> body =
                jsonDecode(request.body) as Map<String, dynamic>;
            final String prompt =
                ((body['messages'] as List).last as Map)['content'] as String;
            final Iterable<String> codes = prompt
                .split('AVAILABLE_COLORS=')
                .last
                .split(',')
                .take(3)
                .map((String entry) => entry.split('#').first);
            return completionResponse(
              paletteJson(<Map<String, String>>[
                for (final String code in codes)
                  <String, String>{
                    'code': code,
                    'role': 'Shadow',
                    'reason': 'deep',
                  },
              ]),
            );
          }),
        );
        await _pump(
          tester,
          env,
          const PalettePage(),
          aiSettings: repo,
          secrets: secrets,
          aiService: service,
        );
        await tester.enterText(
          find.byKey(const ValueKey<String>('palette-base-input')),
          'B08',
        );
        await tester.pumpAndSettle();
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey<String>('palette-suggest-ai')),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-suggest-ai')),
        );
        final Finder report = find.byKey(
          const ValueKey<String>('palette-ai-report'),
        );
        // The button sits above the action buttons: look upwards first.
        await tester.scrollUntilVisible(
          report,
          -200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(report, findsOneWidget, reason: '$_tag report button');
        await tester.pumpAndSettle();
        _check(tester, 'palette with AI result');
        final RenderParagraph label = tester.renderObject(
          find.descendant(of: report, matching: find.byType(RichText)).first,
        );
        expect(_lineCount(label), 1, reason: '$_tag report button label');
        expect(label.didExceedMaxLines, isFalse);
        await _tap(tester, report);
        _check(tester, 'AI report dialog');
        expect(
          find.text(env.t.paletteAiReportTitle),
          findsWidgets,
          reason: '$_tag report dialog title',
        );
        for (final String reason in <String>['offensive', 'wrong', 'other']) {
          final Finder row = find.byKey(
            ValueKey<String>('palette-ai-report-$reason'),
          );
          await _tap(tester, row);
          _check(tester, 'AI report dialog, $reason chosen');
          final RenderParagraph text = tester.renderObject(
            find.descendant(of: row, matching: find.byType(RichText)).first,
          );
          expect(_lineCount(text), 1, reason: '$_tag $reason label');
          expect(text.didExceedMaxLines, isFalse);
        }
        await _close(tester);
      },
  'palette: from a photo, close markers': (WidgetTester tester, _Env env) =>
      _fromPhotoScenario(
        tester,
        env,
        owned: const <String>{'R014', 'G312', 'BV310', 'Y19', 'RV315'},
        expectNote: false,
      ),
  'palette: from a photo, no close marker note':
      (WidgetTester tester, _Env env) => _fromPhotoScenario(
        tester,
        env,
        owned: const <String>{'R014', '0', 'B08'},
        expectNote: true,
      ),
  'match: page, results, recent pick sheet':
      (WidgetTester tester, _Env env) async {
        final FakeImagePickerService picker = FakeImagePickerService(
          PhotoPicked(tinyPng),
        );
        await _pump(
          tester,
          env,
          MatchPage(
            picker: picker,
            decoder: fixedDecoder(sampledImage(64, 64, <int>[255, 0, 0])),
          ),
        );
        _check(tester, 'match');
        await _tap(tester, find.byKey(const ValueKey<String>('match-camera')));
        await _tap(tester, find.byKey(const ValueKey<String>('match-canvas')));
        _check(tester, 'match results');
        await _scroll(tester, 'match results');
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();
        final Finder pick = find.byWidgetPredicate(
          (Widget w) =>
              w.key is ValueKey<String> &&
              (w.key! as ValueKey<String>).value.startsWith('match-pick-') &&
              !(w.key! as ValueKey<String>).value.contains('remove'),
        );
        if (pick.evaluate().isNotEmpty) {
          await _tap(tester, pick);
          _check(tester, 'match pick sheet');
        }
      },
  'ideas: list, idea of the day, tabs and detail sheets':
      (WidgetTester tester, _Env env) async {
        final DateTime today = DateTime(2026, 10, 29);
        await _pump(tester, env, IdeasPage(today: today));
        _check(tester, 'ideas');
        // The idea of the day: detail, other markers, hand-off notice.
        final String featured = IdeasEngine.featuredFor(today).id;
        await _tap(
          tester,
          find.byKey(ValueKey<String>('ideas-open-$featured')),
        );
        _check(tester, 'idea of the day');
        final Finder apply = find.byKey(
          ValueKey<String>('ideas-apply-$featured'),
        );
        if (apply.evaluate().isNotEmpty) {
          await _tap(tester, apply);
          _check(tester, 'idea sent to Palette');
          ScaffoldMessenger.of(tester.element(find.byType(IdeasPage)))
              .removeCurrentSnackBar();
          await tester.pumpAndSettle();
          paletteDraft.value = null;
        } else {
          await _close(tester);
        }
        await _scroll(tester, 'ideas');
        // The longest texts: two-colour roles, skin steps, warm/cool roles,
        // five-step ladders and an exercise without palette.
        for (final String id in <String>[
          'skin_tones',
          'fifty_fifty',
          'two_colors',
          'grayscale',
          'swatch_chart',
        ]) {
          await _tap(tester, find.byKey(ValueKey<String>('ideas-preset-$id')));
          _check(tester, 'idea $id');
          await _scroll(
            tester,
            'idea $id',
            within: find.descendant(
              of: find.byKey(ValueKey<String>('ideas-detail-$id')),
              matching: find.byType(Scrollable),
            ),
          );
          final Finder other = find.byKey(ValueKey<String>('ideas-other-$id'));
          if (other.evaluate().isNotEmpty) {
            await _tap(tester, other);
            _check(tester, 'idea $id, other markers');
          }
          await _close(tester);
        }
        for (final IdeaCategory category in IdeaCategory.values) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('ideas-category-${category.name}')),
          );
          _check(tester, 'ideas ${category.name}');
        }
      },
  'settings: colour theory': (WidgetTester tester, _Env env) async {
    await _pumpSettings(tester, env, provider: AiProvider.local);
    _check(tester, 'settings');
    await _scroll(tester, 'settings');
  },
  'settings: on-device AI on': (WidgetTester tester, _Env env) async {
    await _pumpSettings(
      tester,
      env,
      provider: AiProvider.onDevice,
      enabled: true,
      onDevice: OnDeviceStatus.downloadable,
    );
    await _scroll(tester, 'settings on-device');
  },
  'settings: OpenRouter, model sheets, dialogs':
      (WidgetTester tester, _Env env) async {
        await _pumpSettings(
          tester,
          env,
          provider: AiProvider.openRouter,
          enabled: true,
          withKey: true,
        );
        await _scroll(tester, 'settings openrouter');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ai-load-models')),
        );
        await _scroll(tester, 'settings openrouter models');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ai-text-model-row')),
        );
        _check(tester, 'model picker');
        await _close(tester);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ai-fallbacks-row')),
        );
        _check(tester, 'fallbacks picker');
        await _close(tester);
        await _tap(tester, find.byKey(const ValueKey<String>('ai-remove-key')));
        _check(tester, 'remove key dialog');
      },
  'settings: AI disclosure dialog': (WidgetTester tester, _Env env) async {
    await _pumpSettings(tester, env, provider: AiProvider.openRouter);
    await _tap(tester, find.text(env.t.settingsAiEnabled));
    _check(tester, 'disclosure dialog');
  },
  'collection: Ohuhu series, sets, older sets and the marker list':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const CollectionPage());
        _check(tester, 'collection');
        for (final String id in <String>['honolulu', 'kaala']) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('collection-series-$id')),
          );
        }
        _check(tester, 'collection, every series');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-set-honolulu_24')),
        );
        _check(tester, 'collection, a set owned');
        for (final String id in <String>['oahu', 'honolulu']) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('collection-older-$id')),
          );
        }
        _check(tester, 'collection, older sets open');
        await _scroll(tester, 'collection');
      },
  'collection: nothing chosen yet shows the whole-range summary':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        await scope.settings.setCollection(AppSettings());
        await tester.pumpAndSettle();
        _check(tester, 'collection, nothing chosen');
        expect(find.text(env.t.collectionSummaryNoSets), findsOneWidget);
        await _scroll(tester, 'collection, nothing chosen');
      },
  'collection: loose markers screen, both brands':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(
          tester,
          env,
          const LooseMarkersPage(),
        );
        _check(tester, 'loose markers');
        await tester.enterText(find.byType(TextField), 'B0');
        await tester.pumpAndSettle();
        _check(tester, 'loose markers, searching');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-tick-visible')),
        );
        _check(tester, 'loose markers, ticked');
        await _scroll(tester, 'loose markers, ticked');
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await tester.pumpAndSettle();
        _check(tester, 'loose markers, decotime');
      },
  'collection: DecoTime families and reset dialog':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await tester.pumpAndSettle();
        _check(tester, 'collection decotime');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-family-decotime_base')),
        );
        _check(tester, 'collection decotime, colours owned');
        _check(tester, 'collection decotime');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-reset')),
        );
        _check(tester, 'reset dialog');
        await _close(tester);
        await _scroll(tester, 'collection decotime');
      },
  'onboarding: every step of both brands':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const OnboardingPage());
        _check(tester, 'onboarding brand');
        final Finder next = find.byKey(
          const ValueKey<String>('onboarding-next'),
        );
        await _tap(tester, next);
        for (final String id in <String>['oahu', 'honolulu', 'kaala']) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('collection-series-$id')),
          );
        }
        _check(tester, 'onboarding series');
        await _tap(tester, next);
        _check(tester, 'onboarding sets');
        await _scroll(tester, 'onboarding sets');
        await _tap(tester, next);
        _check(tester, 'onboarding done');
        final Finder back = find.byKey(
          const ValueKey<String>('onboarding-back'),
        );
        for (int i = 0; i < 3; i++) {
          await _tap(tester, back);
        }
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('onboarding-brand-decotime')),
        );
        await _tap(tester, next);
        _check(tester, 'onboarding decotime');
        await _tap(tester, next);
        _check(tester, 'onboarding decotime done');
      },
  'onboarding: nothing chosen, summary and what next':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const OnboardingPage());
        final Finder next = find.byKey(
          const ValueKey<String>('onboarding-next'),
        );
        await _tap(tester, next);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-series-honolulu')),
        );
        _check(tester, 'onboarding series, one chosen');
        await _tap(tester, next);
        // The test scope starts with Oahu 160: untick it, nothing is chosen.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-set-classic_160')),
        );
        await _tap(tester, next);
        _check(tester, 'onboarding done, no sets');
        expect(find.text(env.t.collectionSummaryNoSets), findsOneWidget);
        expect(
          find.text(env.t.onboardingDoneNext, skipOffstage: false),
          findsOneWidget,
        );
        await _scroll(tester, 'onboarding done, no sets');
      },
};

void main() {
  setUpAll(loadAppFonts);

  for (final Locale locale in const <Locale>[Locale('es'), Locale('en')]) {
    for (final double width in const <double>[360, 412]) {
      for (final double scale in const <double>[1.0, 1.3]) {
        final _Env env = _Env(locale, width, scale);
        group(env.tag, () {
          for (final MapEntry<String, _Scenario> s in _scenarios.entries) {
            testWidgets(s.key, (WidgetTester tester) async {
              _problems.clear();
              _tag = env.tag;
              try {
                await s.value(tester, env);
              } on Object catch (e, st) {
                final String at = st
                    .toString()
                    .split('\n')
                    .firstWhere(
                      (String l) =>
                          l.contains('text_fit_test') && !l.contains('_tap'),
                      orElse: () => '',
                    );
                _problems.add(
                  '$_tag scenario error: ${_oneLine('$e').split('  ').first}'
                  ' ${at.trim()}  [${s.key}]',
                );
              }
              expect(_problems, isEmpty, reason: _problems.join('\n'));
            });
          }
        });
      }
    }
  }
}
