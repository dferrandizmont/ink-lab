import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
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
import 'package:ink_lab/ui/pages/settings/backup_section.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_widgets.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/widgets/ink_adaptive.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_disclosure.dart';
import 'package:ink_lab/ui/widgets/ink_overflow_menu.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/select_card.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../ai/ai_test_support.dart';
import '../ai/fake_on_device_platform.dart';
import '../support/fake_backup_file_io.dart';
import '../support/layout_stability.dart';
import '../support/l10n.dart';
import '../support/pill_shapes.dart';
import '../support/tap_targets.dart';
import '../support/truncation.dart';
import 'match/match_test_support.dart';
import 'palette/palette_test_support.dart' show markerColor;

// Regression test for text that does not fit. Spanish, German, French and
// Portuguese run 20-40 % longer than English, so every page and main sheet is
// pumped in all six languages of the app on the
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
  _Env(this.locale, this.width, this.scale, [this.height = 800]);
  final Locale locale;
  final double width;
  final double scale;

  /// Phones are checked 800 high; tablets at their own size.
  final double height;

  AppLocalizations get t => lookupAppLocalizations(locale);
  String get tag =>
      '${locale.languageCode} ${width.toInt()}'
      '${width < 600 ? '' : 'x${height.toInt()}'}dp x$scale';
}

void _size(WidgetTester tester, _Env env) {
  tester.view.physicalSize = Size(env.width, env.height);
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
    // A chip that asks for more lines (the "Add by family" grid) may wrap.
    if (w is InkChip && w.lines > 1) {
      control = false;
      return false;
    }
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
    final String full = error is FlutterError
        ? error.diagnostics.map((n) => n.toStringDeep()).join('\n')
        : error.toString();
    final String first = full.split('\n').first;
    // Where the overflow is: the widgets above the flex that overflowed.
    final int at = full.indexOf('creator:');
    final String creator = at < 0
        ? ''
        : ' in ${_oneLine(full.substring(at + 8, (at + 200).clamp(0, full.length)))}';
    _problems.add('$_tag layout error: $first$creator  [$where]');
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
    if (_lineCount(p) != 1) {
      _problems.add(
        '$_tag type description wraps: "${_oneLine(p.text.toPlainText())}"',
      );
    }
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

/// Scrolls the page to its end.
///
/// A drag over the photo samples a colour instead of scrolling, so the page
/// is moved through its scrollable.
Future<void> _scrollToEnd(WidgetTester tester) async {
  final ScrollableState scroll = tester.state<ScrollableState>(
    find.byType(Scrollable).first,
  );
  scroll.position.jumpTo(scroll.position.maxScrollExtent);
  await tester.pumpAndSettle();
}

/// Closes the top route (sheet or dialog).
Future<void> _close(WidgetTester tester) async {
  final NavigatorState nav = tester.state(find.byType(Navigator).first);
  nav.pop();
  await tester.pumpAndSettle();
}

/// The vertical list of a page: a search field and a chip row also scroll,
/// but sideways, so they are not the list the checks want to walk.
Finder _verticalList() => find.byWidgetPredicate(
  (Widget w) =>
      w is Scrollable &&
      (w.axisDirection == AxisDirection.down ||
          w.axisDirection == AxisDirection.up),
);

/// Opens the folded parts [keys] of the draggable sheet [sheet], scrolling
/// each into reach first (a sheet's content is lazy, so a part below the fold
/// is not built yet). Then reads the whole sheet and returns to the top, so
/// the sheet's header (and its "⋯" menu) stays reachable.
Future<void> _openSheetParts(
  WidgetTester tester,
  Finder sheet,
  List<String> keys,
  String where,
) async {
  final Finder scrollable = find.descendant(
    of: sheet,
    matching: find.byType(Scrollable),
  );
  for (final String key in keys) {
    final Finder target = find.byKey(ValueKey<String>(key));
    await tester.scrollUntilVisible(target, 80, scrollable: scrollable);
    await tester.pumpAndSettle();
    await _tap(tester, target);
  }
  _check(tester, where);
  await _scroll(tester, where, within: scrollable);
  tester.state<ScrollableState>(scrollable).position.jumpTo(0);
  await tester.pumpAndSettle();
}

/// Opens the paint order disclosure (built lazily, so it is scrolled into the
/// built range first) and returns to the top of the page, so the scans below
/// see the whole result with its steps.
Future<void> _openPaintOrder(WidgetTester tester) async {
  final Finder disclosure = find.byKey(
    const ValueKey<String>('palette-paint-order'),
  );
  await tester.scrollUntilVisible(
    disclosure,
    240,
    scrollable: find.byType(Scrollable).first,
  );
  await _tap(tester, disclosure);
  await tester.drag(find.byType(Scrollable).first, const Offset(0, 9000));
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
  // The paint order folds behind a disclosure now: open it so its steps are
  // built and checked.
  await _openPaintOrder(tester);
  var seen = 0;
  await scrollThrough(tester, find.byType(Scrollable).first, (_) {
    seen += _expectSingleLines(tester, 'photo palette');
    _check(tester, 'photo palette');
  });
  expect(seen, greaterThan(0), reason: '$_tag photo palette has rows');
}

typedef _Scenario = Future<void> Function(WidgetTester tester, _Env env);

/// The shared building blocks of the 0.9 UI review (header action, overflow
/// menu, quality text, disclosure with leading / summary, draggable sheet)
/// with real translated texts, so every language is checked at once.
class _FoundationDemo extends StatefulWidget {
  const _FoundationDemo(this.t);

  final AppLocalizations t;

  @override
  State<_FoundationDemo> createState() => _FoundationDemoState();
}

class _FoundationDemoState extends State<_FoundationDemo> {
  bool _open = false;

  List<InkMenuItem> get _items => <InkMenuItem>[
    InkMenuItem(
      key: const ValueKey<String>('demo-copy'),
      label: widget.t.swatchesCopyHex,
      icon: InkIcons.copy,
      onSelected: () {},
    ),
    InkMenuItem(
      label: widget.t.swatchesMyColourWasReset,
      icon: InkIcons.rotateCcw,
      onSelected: () {},
    ),
    InkMenuItem(
      label: widget.t.settingsDeleteFavorite,
      icon: InkIcons.trash2,
      destructive: true,
      onSelected: () {},
    ),
  ];

  Widget _group() => InkDisclosure(
    title: widget.t.swatchesBlendingChain,
    leading: const SizedBox.square(dimension: 20),
    subtitleWidget: const InkQualityText(10.8),
    semanticLabel: widget.t.swatchesBlendingChain,
    expanded: _open,
    padding: EdgeInsets.zero,
    onToggle: () => setState(() => _open = !_open),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const InkQualityText(1.2),
        QualityBadge(widget.t.matchQualityFair),
        InkDefinitionRow(label: widget.t.swatchesHex, value: '#EE315E'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        InkPageHeader(
          title: widget.t.paletteTitle,
          subtitle: widget.t.paletteSavedTitle,
          action: InkOverflowMenu(
            key: const ValueKey<String>('demo-overflow'),
            items: _items,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _group(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkButton.secondary(
            key: const ValueKey<String>('demo-open-sheet'),
            label: widget.t.swatchesCopyHex,
            onPressed: () => showInkDraggableSheet<void>(
              context: context,
              actions: <Widget>[InkOverflowMenu(items: _items)],
              builder: (BuildContext context, ScrollController scroll) =>
                  ListView(
                    controller: scroll,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      // Room for the menu and the close button.
                      Padding(
                        padding: const EdgeInsets.only(right: 104),
                        child: Text(
                          widget.t.swatchesBlendingChain,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _group(),
                      for (int i = 0; i < 12; i++)
                        InkDefinitionRow(
                          label: widget.t.swatchesHex,
                          value: '#EE315E',
                        ),
                    ],
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

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
  'foundation: header action, overflow menu, draggable sheet, quality text':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, _FoundationDemo(env.t));
        _check(tester, 'foundation demo');
        await _tap(tester, find.byKey(const ValueKey<String>('demo-overflow')));
        _check(tester, 'overflow menu open');
        await _close(tester);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('demo-open-sheet')),
        );
        _check(tester, 'draggable sheet at 50 %');
        await _tap(tester, find.text(env.t.swatchesBlendingChain).last);
        _check(tester, 'draggable sheet, group open');
        await tester.drag(
          find.descendant(
            of: find.byType(InkSheet),
            matching: find.byType(Scrollable),
          ),
          const Offset(0, -800),
        );
        await tester.pumpAndSettle();
        _check(tester, 'draggable sheet at 100 %');
        await _scroll(
          tester,
          'draggable sheet at 100 %',
          within: find.descendant(
            of: find.byType(InkSheet),
            matching: find.byType(Scrollable),
          ),
        );
        await _tap(
          tester,
          find.descendant(
            of: find.byType(InkSheet),
            matching: find.byTooltip(env.t.commonMoreActions),
          ),
        );
        _check(tester, 'sheet overflow menu open');
      },
  'swatches: page, filters sheet, detail sheet':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, SwatchesPage(onBlendingChain: (_) {}));
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
        final Finder sheetScroll = find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(Scrollable),
        );
        // The sheet opens at half the height.
        _check(tester, 'swatch detail sheet at 50 %');
        await tester.drag(sheetScroll.first, const Offset(0, -600));
        await tester.pumpAndSettle();
        _check(tester, 'swatch detail sheet at 100 %');
        // The alternatives and the details, open.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-alternatives')),
        );
        _check(tester, 'swatch detail sheet, alternatives open');
        // The details are at the bottom of the sheet: scroll down to them.
        await _scroll(tester, 'swatch detail sheet', within: sheetScroll);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-details')),
        );
        _check(tester, 'swatch detail sheet, details open');
        // The menu of the sheet, with every entry of this marker.
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        _check(tester, 'swatch detail sheet, menu open');
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
          'blendingChain',
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
  'palette: blending chain, its rows, notes and options':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const PalettePage());
        Future<void> baseCode(String code) async {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const ValueKey<String>('palette-base-input')),
            code,
          );
          await tester.pumpAndSettle();
          FocusManager.instance.primaryFocus?.unfocus();
          await tester.pumpAndSettle();
        }

        Future<void> toTop() async {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
        }

        Future<void> screens(String where) async {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 9000),
          );
          await tester.pumpAndSettle();
          var seen = 0;
          await scrollThrough(tester, find.byType(Scrollable).first, (_) {
            seen += _expectSingleLines(tester, where);
            _check(tester, where);
          });
          expect(seen, greaterThan(0), reason: '$_tag $where has rows');
        }

        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-type-field')),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-mode-blendingChain')),
        );
        _check(tester, 'chain type, no base');
        // Five steps: the longest role lines ("Paso 5 · Más oscuro").
        await baseCode('B411');
        expect(
          find.text(env.t.paletteChainResultTitle(5)),
          findsOneWidget,
          reason: '$_tag chain of five',
        );
        // The paint order folds behind a disclosure: open it so its steps are
        // built (and stay open for the rest of the scenario).
        await _openPaintOrder(tester);
        await screens('chain of five');
        // Other chains as options.
        await toTop();
        await _tap(
          tester,
          find.descendant(
            of: find.byType(InkSegmented<int>),
            matching: find.text('4'),
          ),
        );
        // The options sit a few rows down: bring them into the built range.
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey<String>('palette-chain-option-1')),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(
          find.byKey(const ValueKey<String>('palette-chain-option-1')),
          findsOneWidget,
          reason: '$_tag chain options',
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-chain-option-1')),
        );
        await screens('chain option');

        // A short chain, with the base at one end.
        await scope.settings.setCollection(
          AppSettings(
            ownedSetIds: const <String>{},
            extraMarkerIds: const <String>{'B08', 'B010', 'B411'},
          ),
        );
        await tester.pumpAndSettle();
        await toTop();
        await _tap(
          tester,
          find.descendant(
            of: find.byType(InkSegmented<int>),
            matching: find.text('5'),
          ),
        );
        await baseCode('B08');
        expect(
          find.byKey(const ValueKey<String>('palette-chain-note')),
          findsOneWidget,
          reason: '$_tag short chain note',
        );
        await screens('short chain');

        // No chain at all, then the whole range.
        await baseCode('B010');
        await scope.settings.setCollection(
          AppSettings(
            ownedSetIds: const <String>{},
            extraMarkerIds: const <String>{'B010', 'B411'},
          ),
        );
        await tester.pumpAndSettle();
        expect(
          find.text(env.t.paletteChainNeedLighter),
          findsOneWidget,
          reason: '$_tag missing lighter marker',
        );
        _check(tester, 'no chain');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-chain-whole-range')),
        );
        await screens('chain from the whole range');
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
          // The paint order folds behind a disclosure: open it so its steps
          // are built and checked.
          await _openPaintOrder(tester);
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
        _check(tester, 'palette with AI result');
        // Report lives in the result's "⋯" now. The result sits above the
        // actions: the lazy list builds it only once it is scrolled near.
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey<String>('palette-overflow')),
          -200,
          scrollable: find.byType(Scrollable).first,
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-overflow')),
        );
        final Finder report = find.byKey(
          const ValueKey<String>('palette-ai-report'),
        );
        expect(report, findsOneWidget, reason: '$_tag report button');
        await tester.pumpAndSettle();
        final RenderParagraph label = tester.renderObject(
          find.descendant(of: report, matching: find.byType(RichText)).first,
        );
        // A menu entry wraps to two lines at most (InkMenuItem), never cut.
        expect(
          _lineCount(label),
          lessThanOrEqualTo(2),
          reason: '$_tag report button label',
        );
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
        final AppScope scope = await _pump(
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
        // Seven saved picks: six on the page, the rest in the picker.
        for (int i = 0; i < 7; i++) {
          await scope.matchHistory.record(
            ColorMatchPick(
              id: 'pick-$i',
              sampledHex: 'FF0000',
              matchedCode: 'R${101 + i}',
              matchedName: 'Pick number $i',
              matchedHex: 'FF0000',
              deltaE: 1.0 * i,
              createdAtEpochMs: i,
            ),
          );
        }
        await tester.pumpAndSettle();
        await _scrollToEnd(tester);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('match-history-see-all')),
        );
        _check(tester, 'match all the picks');
        await _scroll(
          tester,
          'match all the picks',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
        await _close(tester);
        final Finder pick = find.byWidgetPredicate(
          (Widget w) =>
              w.key is ValueKey<String> &&
              (w.key! as ValueKey<String>).value.startsWith('match-pick-') &&
              !(w.key! as ValueKey<String>).value.contains('remove'),
        );
        if (pick.evaluate().isNotEmpty) {
          await _tap(tester, pick);
          _check(tester, 'match pick sheet');
          await _close(tester);
        }
        // The best of the whole range, folded and open.
        final AppScope withCollection = await _pump(
          tester,
          env,
          MatchPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(sampledImage(64, 64, <int>[0, 0, 255])),
          ),
        );
        // One owned marker that is not close: the page offers the whole range.
        await withCollection.settings.setBrand(MarkerBrand.decoTime);
        await withCollection.settings.setOwnedMarkerCodes(<String>{
          'decotime:01',
        });
        await tester.pumpAndSettle();
        await _tap(tester, find.byKey(const ValueKey<String>('match-camera')));
        await _tap(tester, find.byKey(const ValueKey<String>('match-canvas')));
        _check(tester, 'match with the whole range');
        await _scroll(tester, 'match with the whole range');
        await _scrollToEnd(tester);
        await _tap(tester, find.byKey(const ValueKey<String>('match-range')));
        _check(tester, 'match with the whole range, open');
        await _scroll(tester, 'match with the whole range, open');
      },
  'match: white balance, choosing and refusing a point':
      (WidgetTester tester, _Env env) async {
        // Warm paper on the left, a dark stroke on the right.
        final SampledImage photo = imageFromRgb(8, 8, <List<int>>[
          for (int y = 0; y < 8; y++)
            for (int x = 0; x < 8; x++)
              x < 4 ? <int>[230, 210, 180] : <int>[30, 40, 120],
        ]);
        await _pump(
          tester,
          env,
          MatchPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(photo),
          ),
        );
        await _tap(tester, find.byKey(const ValueKey<String>('match-camera')));
        _check(tester, 'match with a photo: fix white balance');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('white-balance-start')),
        );
        _check(tester, 'match choosing the white');
        final Rect canvas = tester.getRect(
          find.byKey(const ValueKey<String>('match-canvas')),
        );
        // The dark stroke is not paper: it says so.
        await tester.tapAt(canvas.center + const Offset(40, 0));
        await tester.pumpAndSettle();
        expect(find.text(env.t.matchWhiteBalanceTooDark), findsOneWidget);
        _check(tester, 'match white refused');
        await tester.tapAt(canvas.center - const Offset(40, 0));
        await tester.pumpAndSettle();
        expect(find.text(env.t.matchWhiteBalanceOn), findsOneWidget);
        _check(tester, 'match white balance on');
        await tester.tapAt(canvas.center + const Offset(40, 0));
        await tester.pumpAndSettle();
        _check(tester, 'match results, white balance on');
        await _scroll(tester, 'match results, white balance on');
      },
  'match: empty state, value view and the sample read aloud':
      (WidgetTester tester, _Env env) async {
        await _pump(
          tester,
          env,
          MatchPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(sampledImage(64, 64, <int>[200, 60, 60])),
          ),
        );
        // Before a photo: one line and two big, equal actions.
        _check(tester, 'match empty state');
        await _scroll(tester, 'match empty state');
        await _tap(tester, find.byKey(const ValueKey<String>('match-camera')));
        await _tap(tester, find.byKey(const ValueKey<String>('match-canvas')));
        _check(tester, 'match with a sample');
        await _tap(tester, find.byKey(const ValueKey<String>('match-values')));
        _check(tester, 'match, value view on');
        await _scroll(tester, 'match, value view on');
      },
  'swatches: a hex search shows the closest markers':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const SwatchesPage());
        await _tap(tester, find.text(env.t.swatchesAllFilter));
        await tester.enterText(find.byType(TextField), '#2D6E9C');
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey<String>('swatches-closest-to')),
          findsOneWidget,
        );
        expect(find.text(env.t.swatchesClosestTo('#2D6E9C')), findsOneWidget);
        _check(tester, 'swatches hex search');
      },
  'swatches: my colour in the detail sheet and the editor':
      (WidgetTester tester, _Env env) async {
        final SampledImage photo = imageFromRgb(8, 8, <List<int>>[
          for (int y = 0; y < 8; y++)
            for (int x = 0; x < 8; x++)
              x < 4 ? <int>[230, 210, 180] : <int>[30, 40, 120],
        ]);
        final AppScope scope = await _pump(
          tester,
          env,
          SwatchesPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(photo),
          ),
        );
        await scope.ownColors.set('R101', '334455');
        await tester.pumpAndSettle();
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();
        await _tap(tester, find.text('B08'));
        _check(tester, 'detail sheet, no own colour');
        await _scroll(
          tester,
          'detail sheet, no own colour',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-my-colour-row')),
        );
        _check(tester, 'own colour editor');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('own-color-gallery')),
        );
        _check(tester, 'own colour editor with a photo');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('white-balance-start')),
        );
        _check(tester, 'own colour editor choosing the white');
        await tester.enterText(
          find.byKey(const ValueKey<String>('own-color-hex')),
          '12',
        );
        await tester.pumpAndSettle();
        _check(tester, 'own colour editor, invalid hex');
        await tester.enterText(
          find.byKey(const ValueKey<String>('own-color-hex')),
          '3a7f9c',
        );
        await tester.pumpAndSettle();
        await _scroll(tester, 'own colour editor');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('own-color-save')),
        );
        // Back on the sheet: the row shows the colour the user stored.
        _check(tester, 'detail sheet with an own colour');
        expect(
          find.text(env.t.swatchesMyColourValue('#3A7F9C')),
          findsOneWidget,
        );
        await _scroll(
          tester,
          'detail sheet with an own colour',
          within: find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(Scrollable),
          ),
        );
      },
  'swatches: brand equivalents in the detail sheet':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const SwatchesPage());
        await scope.settings.setOwnedMarkerCodes(<String>{'copic:B00'});
        await tester.pumpAndSettle();
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();
        await _tap(tester, find.text('B08'));
        final Finder sheetScroll = find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first;
        // The sheet at the full height: the section is on screen.
        await tester.drag(sheetScroll, const Offset(0, -600));
        await tester.pumpAndSettle();
        _check(tester, 'in other brands');
        await _scroll(tester, 'in other brands', within: sheetScroll);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-equivalents-only-mine')),
        );
        _check(tester, 'in other brands, only mine');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-equivalents-only-mine')),
        );
        // A marker of another brand: no palette actions, a note.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-equivalents-copic')),
        );
        _check(tester, 'in other brands, a group open');
        await _tap(
          tester,
          find.descendant(
            of: find.byKey(const ValueKey<String>('swatch-equivalents-copic')),
            matching: find.byWidgetPredicate(
              (Widget w) =>
                  w.key is ValueKey<String> &&
                  (w.key! as ValueKey<String>).value.startsWith(
                    'swatch-equivalent-',
                  ),
            ),
          ),
        );
        _check(tester, 'detail sheet of another brand');
        await _scroll(
          tester,
          'detail sheet of another brand',
          within: sheetScroll,
        );
      },
  'palette: colour vision preview': (WidgetTester tester, _Env env) async {
    final AppScope scope = await _pump(tester, env, const PalettePage());
    await scope.savedPalettes.save(
      SavedPalette(
        id: 'p1',
        name: 'Stored sky',
        baseCode: 'B08',
        baseName: 'Cotton Candy Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 1,
        colorCodes: const <String>['B08', 'B08', 'BV19'],
      ),
    );
    await tester.pumpAndSettle();
    // No palette yet: nothing to preview.
    _check(tester, 'colour vision with saved palettes');
    await tester.enterText(
      find.byKey(const ValueKey<String>('palette-base-input')),
      'B08',
    );
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    // The preview moved into a sheet, opened from the result's "⋯".
    await _tap(tester, find.byKey(const ValueKey<String>('palette-overflow')));
    await _tap(
      tester,
      find.byKey(const ValueKey<String>('palette-vision-open')),
    );
    final Finder control = find.byKey(const ValueKey<String>('palette-vision'));
    for (final String label in <String>[
      env.t.paletteVisionDeuteranopia,
      env.t.paletteVisionAchromatopsia,
    ]) {
      await _tap(
        tester,
        find.descendant(of: control, matching: find.text(label)),
      );
      _check(tester, 'colour vision $label');
    }
    await _scroll(tester, 'colour vision preview');
  },
  'settings: own colours, count and reset dialog':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pumpSettings(
          tester,
          env,
          provider: AiProvider.local,
        );
        _check(tester, 'settings, no own colours');
        await scope.ownColors.set('R101', '334455');
        await scope.ownColors.set('decotime:01', '112233');
        await tester.pumpAndSettle();
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('settings-own-colors-reset')),
        );
        _check(tester, 'reset own colours dialog');
        await _close(tester);
        // The favourites live behind a sheet: its list has to fit too.
        await scope.settings.setFavorites(<String>{'ohuhu_oahu:YR114'});
        await tester.pumpAndSettle();
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('settings-favorites-row')),
        );
        _check(tester, 'favourites sheet');
        await _scroll(
          tester,
          'favourites sheet',
          within: find.descendant(
            of: find.byKey(const ValueKey<String>('settings-favorites-list')),
            matching: find.byType(Scrollable),
          ),
        );
        await _close(tester);
        await _scroll(tester, 'settings with own colours');
      },
  'ideas: diary list, entry form, pickers and photo viewer':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(
          tester,
          env,
          IdeasPage(
            today: DateTime(2026, 10, 29),
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
          ),
        );
        await scope.savedPalettes.save(
          SavedPalette(
            id: 'fit',
            name: 'Sunrise',
            baseCode: 'B08',
            baseName: 'Cotton Candy Blue',
            mode: PaletteMode.triad,
            paletteSize: 3,
            createdAtEpochMs: 1,
            colorCodes: const <String>['B08', 'BV04', 'YR57'],
          ),
        );
        await _tap(tester, find.text(env.t.ideasDiarySegment));
        _check(tester, 'diary, empty');
        expect(find.text(env.t.diaryEmptyTitle), findsOneWidget);

        // The form, new: every field, the pickers and four photos.
        await _tap(tester, find.text(env.t.diaryAdd));
        _check(tester, 'diary form, new');
        await tester.enterText(
          find.byKey(const ValueKey<String>('diary-title')),
          'A page of the autumn forest colouring book',
        );
        // The optional fields live in "More details".
        await _tap(tester, find.byKey(const ValueKey<String>('diary-details')));
        _check(tester, 'diary form, more details');
        await tester.enterText(
          find.byKey(const ValueKey<String>('diary-on-what')),
          'Forest colouring book, page 12',
        );
        await tester.enterText(
          find.byKey(const ValueKey<String>('diary-notes')),
          'Wet blending on thick paper, three layers of warm colours.',
        );
        await tester.pumpAndSettle();
        final List<MarkerColor> owned = ownedColors(
          colors: await scope.markers.loadColors(MarkerBrand.ohuhuOahu),
          brand: MarkerBrand.ohuhuOahu,
          ownedSetIds: scope.settings.settings.effectiveSetIds(),
          ownedMarkerCodes: scope.settings.settings.ownedMarkerCodes,
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('diary-markers-choose')),
        );
        _check(tester, 'diary marker picker');
        for (final MarkerColor marker in owned.take(6)) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('diary-marker-${marker.newCode}')),
          );
        }
        _check(tester, 'diary marker picker, ticked');
        await _close(tester);
        _check(tester, 'diary form, markers');
        await _tap(tester, find.byKey(const ValueKey<String>('diary-palette')));
        _check(tester, 'diary palette picker');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('diary-palette-fit')),
        );
        await _tap(tester, find.text(env.t.diaryStatusInProgress));
        for (var i = 0; i < 4; i++) {
          await _tap(
            tester,
            find.byKey(const ValueKey<String>('diary-photo-gallery')),
          );
        }
        _check(tester, 'diary form, four photos');
        await _scroll(tester, 'diary form, filled');
        await _tap(tester, find.byKey(const ValueKey<String>('diary-save')));
        _check(tester, 'diary list, one entry');
        ScaffoldMessenger.of(tester.element(find.byType(IdeasPage)))
            .removeCurrentSnackBar();
        await tester.pumpAndSettle();
        await _scroll(tester, 'diary list, one entry');

        // A second, plain entry; both listed.
        await scope.artworkDiary.save(
          ArtworkEntry(
            id: 'plain',
            title: 'Quick sheet',
            date: DateTime(2026, 1, 3),
            createdAtEpochMs: 1,
          ),
        );
        await tester.pumpAndSettle();
        _check(tester, 'diary list, two entries');

        // The diary numbers: every section, the unused list opened.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('diary-stats-card')),
        );
        _check(tester, 'diary numbers');
        await _scroll(tester, 'diary numbers');
        final Finder unusedToggle = find.byKey(
          const ValueKey<String>('diary-stats-unused-toggle'),
        );
        if (unusedToggle.evaluate().isNotEmpty) {
          await _tap(tester, unusedToggle);
          _check(tester, 'diary numbers, unused markers');
          await _scroll(tester, 'diary numbers, unused markers');
        }
        final Finder palettesToggle = find.byKey(
          const ValueKey<String>('diary-stats-palettes-toggle'),
        );
        if (palettesToggle.evaluate().isNotEmpty) {
          await _tap(tester, palettesToggle);
          _check(tester, 'diary numbers, palettes');
          await _scroll(tester, 'diary numbers, palettes');
        }
        await _close(tester);

        // Open a photo at full screen, then the entry to edit.
        final String photo = scope.artworkDiary.entries
            .firstWhere((ArtworkEntry e) => e.photos.isNotEmpty)
            .photos
            .first;
        await _tap(tester, find.byKey(ValueKey<String>('diary-thumb-$photo')));
        _check(tester, 'diary photo viewer');
        await _close(tester);
        await tester.tapAt(
          tester.getTopLeft(
                find.byKey(
                  ValueKey<String>(
                    'diary-entry-${scope.artworkDiary.entries.first.id}',
                  ),
                ),
              ) +
              const Offset(8, 8),
        );
        await tester.pumpAndSettle();
        _check(tester, 'diary form, edit');
        await _scroll(tester, 'diary form, edit');
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        await _tap(tester, find.byKey(const ValueKey<String>('diary-delete')));
        _check(tester, 'diary delete dialog');
        await _close(tester);
        await _close(tester);
      },
  'ideas: list, idea of the day, tabs and detail sheets':
      (WidgetTester tester, _Env env) async {
        final DateTime today = DateTime(2026, 10, 29);
        await _pump(tester, env, IdeasPage(today: today));
        _check(tester, 'ideas');
        // The idea of the day opens at half height; the whole card is the
        // tap target (no "See steps" button).
        final String featured = IdeasEngine.featuredFor(today).id;
        await _tap(
          tester,
          find.byKey(ValueKey<String>('ideas-open-$featured')),
        );
        _check(tester, 'idea of the day at half height');
        // Drag to full height, then read the whole sheet with both
        // disclosures open and the "⋯" menu unfolded.
        final Finder sheet = find.byKey(
          ValueKey<String>('ideas-detail-$featured'),
        );
        await tester.drag(sheet, const Offset(0, -600));
        await tester.pumpAndSettle();
        _check(tester, 'idea of the day at full height');
        await _openSheetParts(tester, sheet, <String>[
          'ideas-markers-$featured',
          'ideas-details-$featured',
        ], 'idea of the day, everything open');
        // The "⋯" menu: add to diary and other markers.
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        _check(tester, 'idea of the day, menu');
        await _tap(
          tester,
          find.byKey(ValueKey<String>('ideas-other-$featured')),
        );
        _check(tester, 'idea of the day, other markers');
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
        await _scroll(tester, 'ideas', within: _verticalList().first);
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
          final Finder sheet = find.byKey(ValueKey<String>('ideas-detail-$id'));
          await tester.drag(sheet, const Offset(0, -600));
          await tester.pumpAndSettle();
          await _openSheetParts(tester, sheet, <String>[
            if (IdeasEngine.byId(id)!.hasPalette) 'ideas-markers-$id',
            'ideas-details-$id',
          ], 'idea $id, everything open');
          await _tap(tester, find.byTooltip(env.t.commonMoreActions));
          _check(tester, 'idea $id, menu');
          final Finder other = find.byKey(ValueKey<String>('ideas-other-$id'));
          if (other.evaluate().isNotEmpty) {
            await _tap(tester, other);
            _check(tester, 'idea $id, other markers');
          } else {
            await _close(tester);
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
  'ideas: favourites and recently viewed':
      (WidgetTester tester, _Env env) async {
        final DateTime today = DateTime(2026, 10, 29);
        final AppScope scope = await _pump(
          tester,
          env,
          IdeasPage(today: today),
        );
        // The Favourites chip with nothing in it: the empty state.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ideas-category-favorites')),
        );
        _check(tester, 'ideas favourites, empty');
        // Hearts on the longest ideas, then the filter and the recent row.
        const List<String> ids = <String>[
          'skin_tones',
          'fifty_fifty',
          'two_colors',
          'grayscale',
        ];
        for (final String id in ids) {
          await scope.ideaFavorites.toggle(id);
          await scope.ideaFavorites.recordViewed(id);
        }
        await tester.pumpAndSettle();
        _check(tester, 'ideas favourites');
        await _scroll(
          tester,
          'ideas favourites',
          within: _verticalList().first,
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ideas-category-all')),
        );
        _check(tester, 'ideas recently viewed');
        final Finder recent = find.byKey(
          const ValueKey<String>('ideas-recent'),
        );
        await tester.scrollUntilVisible(
          recent,
          200,
          scrollable: _verticalList().first,
        );
        await tester.pumpAndSettle();
        _check(tester, 'ideas recently viewed, folded');
        await _tap(tester, recent);
        _check(tester, 'ideas recently viewed row');
        // The heart in the sheet.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ideas-recent-skin_tones')),
        );
        _check(tester, 'idea sheet with a heart');
        await _close(tester);
      },
  'settings: backup file': (WidgetTester tester, _Env env) async {
    final FakeBackupFileIo io = FakeBackupFileIo()
      ..pick = pickOf(Uint8List.fromList(<int>[0x50, 0x4B, 3, 4, 0, 0]));
    await _pump(
      tester,
      env,
      SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) =>
              BackupSection(scope: AppScope.of(context), fileIo: io),
        ),
      ),
    );
    _check(tester, 'backup file');
    // The copy by text, folded: its two buttons have to fit as well.
    await _tap(tester, find.text(env.t.settingsBackupTextTitle));
    _check(tester, 'backup file, copy by text');
    // The question before a restore, then a refusal from the archive.
    await _tap(
      tester,
      find.byKey(const ValueKey<String>('settings-backup-file-restore')),
    );
    _check(tester, 'backup file restore question');
    await _close(tester);
    // The progress line while the backup is built.
    io.shareGate = Completer<void>();
    await tester.tap(
      find.byKey(const ValueKey<String>('settings-backup-file-save')),
    );
    await tester.pump();
    await tester.pump();
    _check(tester, 'backup file progress');
    io.shareGate!.complete();
    await tester.pumpAndSettle();
    // A refusal message in the snackbar.
    await _tap(
      tester,
      find.byKey(const ValueKey<String>('settings-backup-file-restore')),
    );
    await _tap(
      tester,
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text(env.t.settingsImportConfirm),
      ),
    );
    _check(tester, 'backup file refusal');
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
  'settings: Language row and picker': (WidgetTester tester, _Env env) async {
    await _pump(tester, env, const SettingsPage());
    final Finder row = find.byKey(const ValueKey<String>('settings-language'));
    await _tap(tester, row);
    expect(
      find.byKey(const ValueKey<String>('language-list')),
      findsOneWidget,
      reason: '$_tag language picker',
    );
    _check(tester, 'language picker');
    // Every option is named in itself and fits on one line.
    for (final String name in <String>[
      'Español',
      'English',
      'Deutsch',
      'Français',
      'Português',
      'Italiano',
    ]) {
      expect(find.text(name), findsWidgets, reason: '$_tag $name');
    }
    await _close(tester);
    _check(tester, 'settings with the language row');
    await _scroll(tester, 'settings with the language row');
  },
  'switching segments never moves the header: ideas | diary':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, IdeasPage(today: DateTime(2026, 10, 29)));
        final Finder view = find.byKey(const ValueKey<String>('ideas-view'));
        Future<void> tapSegment(String label) async {
          await tester.tap(
            find.descendant(of: view, matching: find.text(label)),
          );
          await tester.pumpAndSettle();
          _check(tester, 'ideas | diary: $label');
        }

        await expectStableAcrossSegments(
          tester,
          env: StabilityEnv(env.locale, env.width, env.scale),
          anchors: <String, Finder>{
            'header': find.byType(InkPageHeader),
            'control': view,
          },
          segments: <StabilitySegment>[
            (name: 'ideas', activate: () async {}),
            (
              name: 'diary',
              activate: () => tapSegment(env.t.ideasDiarySegment),
            ),
            (name: 'ideas again', activate: () => tapSegment(env.t.ideasTitle)),
          ],
        );
      },
  'switching types never moves the header: palette type':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const PalettePage());
        Future<void> pick(String rowKey) async {
          // A plain tap (not _tap): ensureVisible would scroll the page to
          // put the field at the top, which is not what the user does.
          await tester.tap(
            find.byKey(const ValueKey<String>('palette-type-field')),
          );
          await tester.pumpAndSettle();
          await _tap(tester, find.byKey(ValueKey<String>(rowKey)));
          _check(tester, 'palette type $rowKey');
        }

        await expectStableAcrossSegments(
          tester,
          env: StabilityEnv(env.locale, env.width, env.scale),
          anchors: <String, Finder>{
            'header': find.byType(InkPageHeader),
            'saved palettes action': find.byKey(
              const ValueKey<String>('palette-saved-palettes'),
            ),
            'type field': find.byKey(
              const ValueKey<String>('palette-type-field'),
            ),
          },
          segments: <StabilitySegment>[
            (name: 'recommended', activate: () async {}),
            (
              name: 'custom palette',
              activate: () => pick('palette-mode-customPalette'),
            ),
            (name: 'triad', activate: () => pick('palette-mode-triad')),
            (
              name: 'recommended again',
              activate: () => pick('palette-mode-recommended'),
            ),
          ],
        );
      },
  'switching brands never moves the selector: collection':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        await expectStableAcrossSegments(
          tester,
          env: StabilityEnv(env.locale, env.width, env.scale),
          anchors: <String, Finder>{
            'brand selector': find.byKey(
              const ValueKey<String>('collection-brand'),
            ),
            'summary': find.byKey(const ValueKey<String>('collection-summary')),
          },
          // The card below the selector is content: its height follows the
          // brand.
          topOnly: <String>{'summary'},
          segments: <StabilitySegment>[
            for (final MarkerBrand brand in <MarkerBrand>[
              ...MarkerBrand.values,
              MarkerBrand.values.first,
            ])
              (
                name: brand.id,
                activate: () async {
                  await scope.settings.setBrand(brand);
                  _check(tester, 'collection ${brand.id}');
                },
              ),
          ],
        );
      },
  'switching the filter never moves the control: AI model picker':
      (WidgetTester tester, _Env env) async {
        await _pumpSettings(
          tester,
          env,
          provider: AiProvider.openRouter,
          enabled: true,
          withKey: true,
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ai-load-models')),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('ai-text-model-row')),
        );
        final Finder filter = find.byType(InkSegmented<AiModelFilter>);
        Future<void> tapSegment(String label) async {
          await tester.tap(
            find.descendant(of: filter, matching: find.text(label)),
          );
          await tester.pumpAndSettle();
          _check(tester, 'model picker: $label');
        }

        await expectStableAcrossSegments(
          tester,
          env: StabilityEnv(env.locale, env.width, env.scale),
          anchors: <String, Finder>{'filter control': filter},
          segments: <StabilitySegment>[
            (name: 'free', activate: () async {}),
            (
              name: 'paid',
              activate: () => tapSegment(env.t.settingsAiModelsFilterPaid),
            ),
            (
              name: 'both',
              activate: () => tapSegment(env.t.settingsAiModelsFilterBoth),
            ),
            (
              name: 'free again',
              activate: () => tapSegment(env.t.settingsAiModelsFilterFree),
            ),
          ],
        );
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
        // The series and the sets start folded (spec §2.6).
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-series')),
        );
        _check(tester, 'collection, series open');
        for (final String id in <String>['honolulu', 'kaala']) {
          await _tap(
            tester,
            find.byKey(ValueKey<String>('collection-series-$id')),
          );
        }
        _check(tester, 'collection, every series');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-sets')),
        );
        _check(tester, 'collection, sets open');
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
  'collection: printable swatch chart card, all brands and the empty state':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        final Finder card = find.byKey(
          const ValueKey<String>('collection-chart'),
        );
        await tester.ensureVisible(card);
        await tester.pumpAndSettle();
        _check(tester, 'chart card');
        // The card starts folded; open it to reach the switch (spec §2.6).
        await _tap(tester, card);
        _check(tester, 'chart card, open');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('collection-chart-colour')),
        );
        _check(tester, 'chart card, catalogue colour on');
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await tester.pumpAndSettle();
        await tester.ensureVisible(card);
        await tester.pumpAndSettle();
        _check(tester, 'chart card, nothing owned');
        expect(find.text(env.t.collectionChartEmpty), findsOneWidget);
        await scope.settings.setBrand(MarkerBrand.copic);
        await tester.pumpAndSettle();
        await tester.ensureVisible(card);
        await tester.pumpAndSettle();
        _check(tester, 'chart card, copic');
        expect(find.text(env.t.collectionChartEmpty), findsOneWidget);
        for (final MarkerBrand brand in MarkerBrand.values.skip(3)) {
          await scope.settings.setBrand(brand);
          await tester.pumpAndSettle();
          await tester.ensureVisible(card);
          await tester.pumpAndSettle();
          _check(tester, 'chart card, ${brand.id}');
        }
      },
  'palette: saved palette row with Share':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const PalettePage());
        await scope.savedPalettes.save(
          SavedPalette(
            id: 'fit',
            name: 'A saved palette with a rather long name',
            baseCode: 'B08',
            baseName: 'Cotton Candy Blue',
            mode: PaletteMode.triad,
            paletteSize: 3,
            createdAtEpochMs: 1,
            colorCodes: const <String>['B08', 'BV04', 'YR57'],
          ),
        );
        await tester.pumpAndSettle();
        // The saved palettes, and their Share, now live in the selector sheet.
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-saved-palettes')),
        );
        _check(tester, 'saved palette row');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('palette-saved-menu-fit')),
        );
        await tester.ensureVisible(
          find.byKey(const ValueKey<String>('palette-share-fit')),
        );
        await tester.pumpAndSettle();
        _check(tester, 'saved palette row share menu');
        await _scroll(tester, 'saved palette row');
      },
  'collection: loose markers screen, all brands':
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
        await scope.settings.setBrand(MarkerBrand.copic);
        await tester.pumpAndSettle();
        _check(tester, 'loose markers, copic');
        await _scroll(tester, 'loose markers, copic');
        // Finecolour and every brand added after it (15 brands in all).
        for (final MarkerBrand brand in MarkerBrand.values.skip(3)) {
          await scope.settings.setBrand(brand);
          await tester.pumpAndSettle();
          _check(tester, 'loose markers, ${brand.id}');
          await _scroll(tester, 'loose markers, ${brand.id}');
        }
      },
  'collection: Copic ownership, purchase suggestions, wishlist and dried markers':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        await scope.settings.setBrand(MarkerBrand.copic);
        await scope.settings.setOwnedMarkerCodes({
          'copic:BV04',
          'copic:B05',
          'copic:R29',
        });
        await scope.wishlist.add('copic:Y08');
        await scope.dried.add('copic:B05');
        await tester.pumpAndSettle();
        _check(tester, 'collection copic');
        await _scroll(tester, 'collection copic');
      },
  'collection: Finecolour ownership, purchase suggestions, wishlist and dried markers':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        await scope.settings.setBrand(MarkerBrand.finecolour);
        await scope.settings.setOwnedMarkerCodes({
          'finecolour:BV321',
          'finecolour:B94',
          'finecolour:R140',
        });
        await scope.wishlist.add('finecolour:Y1');
        await scope.dried.add('finecolour:B94');
        await tester.pumpAndSettle();
        _check(tester, 'collection finecolour');
        await _scroll(tester, 'collection finecolour');
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
  'collection: what to buy next, wishlist and dried out cards':
      (WidgetTester tester, _Env env) async {
        final AppScope scope = await _pump(tester, env, const CollectionPage());
        _check(tester, 'collection, what to buy next');
        expect(
          find.byKey(const ValueKey<String>('collection-buy-next')),
          findsOneWidget,
        );
        await _scroll(tester, 'collection, what to buy next');
        for (final String id in <String>['BV04', 'B28', 'BV35', 'R16', 'B08']) {
          await scope.wishlist.add(id);
        }
        await scope.dried.add('B08');
        await scope.dried.add('R16');
        await tester.pumpAndSettle();
        _check(tester, 'collection, wishlist and dried');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('wishlist-disclosure')),
        );
        _check(tester, 'collection, wishlist open');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('dried-disclosure')),
        );
        _check(tester, 'collection, dried list open');
        await _tap(tester, find.byKey(const ValueKey<String>('wishlist-copy')));
        _check(tester, 'collection, list copied');
        await _scroll(tester, 'collection, wishlist and dried');
        await scope.settings.setCollection(AppSettings());
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey<String>('buy-next-empty')),
          findsOneWidget,
        );
        _check(tester, 'collection, no collection for what to buy next');
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await scope.wishlist.add('decotime:01');
        await tester.pumpAndSettle();
        _check(tester, 'collection decotime, wishlist');
      },
  'swatches: grid cells show every line of long names, with the marks on':
      (WidgetTester tester, _Env env) async {
        const List<String> names = <String>[
          "Robin's Egg Blue",
          'Warm Gray No.7',
          'Pale Cherry Pink',
          'Light Reddish Violet',
          'Cotton Candy Blue',
          'Turquoise',
        ];
        Future<void> pumpGrid({required bool showHex}) async {
          await _pump(
            tester,
            env,
            Builder(
              builder: (BuildContext context) => GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: ColorSwatchTile.gridDelegate(
                  context,
                  showHex: showHex,
                ),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int i) => ColorSwatchTile(
                  hex: '#8FB8D0',
                  code: 'B${i + 1}4',
                  name: names[i],
                  owned: i.isEven,
                  ownColor: i == 0 || i == 3,
                  dried: i == 1,
                  showHex: showHex,
                ),
              ),
            ),
          );
        }

        void checkNames(String where) {
          // Every name line fits in its box and inside the card: nothing is
          // painted past the bottom edge.
          for (final String name in names) {
            final Finder paragraph = find.text(name);
            expect(paragraph, findsOneWidget);
            final RenderParagraph render = tester.renderObject<RenderParagraph>(
              paragraph,
            );
            final double wanted = render.getMinIntrinsicHeight(
              render.size.width,
            );
            if (wanted > render.size.height + 0.5) {
              _problems.add(
                '$_tag clipped name: "$name" needs $wanted, has '
                '${render.size.height}  [$where]',
              );
            }
            final Rect tile = tester.getRect(
              find.ancestor(
                of: paragraph,
                matching: find.byType(ColorSwatchTile),
              ),
            );
            final Rect text = tester.getRect(paragraph);
            if (text.top + wanted > tile.bottom + 0.5) {
              _problems.add('$_tag name past the card: "$name"  [$where]');
            }
            // No word may be wider than the name's text box: a word that does
            // not fit cannot wrap and is cut, which is exactly what the grid
            // must avoid ("Turquoi / se").
            final TextSpan span = render.text as TextSpan;
            final TextPainter painter = TextPainter(
              textDirection: TextDirection.ltr,
              textScaler: render.textScaler,
              maxLines: 1,
            );
            for (final String word in name.split(' ')) {
              painter.text = TextSpan(text: word, style: span.style);
              painter.layout();
              if (painter.width > render.size.width + 0.5) {
                _problems.add(
                  '$_tag word wider than its box: "$word" of "$name" needs '
                  '${painter.width}, has ${render.size.width}  [$where]',
                );
              }
            }
          }
        }

        // The grid of the page: no hex line, so the cells are lower.
        await pumpGrid(showHex: false);
        _check(tester, 'swatch grid cells');
        expect(find.text('#8FB8D0'), findsNothing);
        checkNames('swatch grid cells');

        // A cell with the hex (the list and the detail sheet keep it).
        await pumpGrid(showHex: true);
        _check(tester, 'swatch grid cells with the hex');
        checkNames('swatch grid cells with the hex');
      },
  'swatches: wishlist and dried out in the detail sheet':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, const SwatchesPage());
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();
        await _tap(tester, find.text('B08'));
        final Finder sheetScroll = find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(Scrollable),
        );
        _check(tester, 'detail sheet, wishlist and dried controls');
        // The wishlist and the dried-out mark live in the "⋯" menu.
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        _check(tester, 'detail sheet, menu open');
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-menu-wishlist')),
        );
        _check(tester, 'detail sheet, on the wishlist');
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-menu-dried')),
        );
        _check(tester, 'dried out, wishlist offer already taken');
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-menu-dried')),
        );
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-menu-wishlist')),
        );
        await _tap(tester, find.byTooltip(env.t.commonMoreActions));
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-menu-dried')),
        );
        _check(tester, 'dried out, offer to add to the wishlist');
        expect(find.byType(AlertDialog), findsOneWidget);
        await _close(tester);
        _check(tester, 'detail sheet, dried out');
        await _scroll(tester, 'detail sheet, dried out', within: sheetScroll);
      },
  'onboarding: every step of all brands':
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
        await _tap(tester, back);
        await _tap(tester, back);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('onboarding-brand-copic')),
        );
        await _tap(tester, next);
        _check(tester, 'onboarding copic');
        await _tap(tester, next);
        _check(tester, 'onboarding copic done');
        await _tap(tester, back);
        await _tap(tester, back);
        // The full-width buttons leave less room: the last card may be
        // beyond the list's built area until the list is scrolled.
        await tester.dragUntilVisible(
          find.byKey(const ValueKey<String>('onboarding-brand-finecolour')),
          find.byType(ListView),
          const Offset(0, -80),
        );
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('onboarding-brand-finecolour')),
        );
        await _tap(tester, next);
        _check(tester, 'onboarding finecolour');
        await _tap(tester, next);
        _check(tester, 'onboarding finecolour done');
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

  group('SwatchGridDelegate', () {
    // The count the delegate picks for a device of [deviceWidth] dp with the
    // system text at [scale]. The grid is inset by the page margin on both
    // sides, so the sliver's cross-axis extent is narrower than the screen.
    int columns(double deviceWidth, double scale) {
      final SliverGridDelegate delegate = SwatchGridDelegate(
        textScale: scale,
        showHex: false,
        cellHeight: 100,
      );
      final SliverGridLayout layout = delegate.getLayout(
        SliverConstraints(
          axisDirection: AxisDirection.down,
          growthDirection: GrowthDirection.forward,
          userScrollDirection: ScrollDirection.idle,
          scrollOffset: 0,
          precedingScrollExtent: 0,
          overlap: 0,
          remainingPaintExtent: 600,
          crossAxisExtent: deviceWidth - 2 * InkSpacing.pageMargin,
          crossAxisDirection: AxisDirection.right,
          viewportMainAxisExtent: 600,
          remainingCacheExtent: 600,
          cacheOrigin: 0,
        ),
      );
      return (layout as SliverGridRegularTileLayout).crossAxisCount;
    }

    test('412 dp: 3 columns at normal text, 2 at 1.3', () {
      expect(columns(412, 1.0), 3);
      expect(columns(412, 1.3), 2);
    });

    test('360 dp: 3 columns at normal text, 2 at 1.3', () {
      expect(columns(360, 1.0), 3);
      expect(columns(360, 1.3), 2);
    });

    test('a wide screen keeps the old max-extent count', () {
      // What the grid had before this delegate: as many 130 dp cells as fit.
      final int old =
          ((800 - 2 * InkSpacing.pageMargin) / (130 + InkSpacing.block)).ceil();
      expect(columns(800, 1.0), old);
    });
  });

  for (final Locale locale in AppLocalizations.supportedLocales) {
    for (final double width in const <double>[360, 412]) {
      for (final double scale in const <double>[1.0, 1.3]) {
        final _Env env = _Env(locale, width, scale);
        group(env.tag, () {
          for (final MapEntry<String, _Scenario> s in _scenarios.entries) {
            testWidgets(
              s.key,
              (WidgetTester tester) => _runScenario(tester, env, s),
            );
          }
        });
      }
    }
    // Tablets, portrait and landscape, at normal text: the main pages and
    // their sheets in every language.
    for (final Size size in tabletSizes) {
      final _Env env = _Env(locale, size.width, 1.0, size.height);
      group(env.tag, () {
        for (final MapEntry<String, _Scenario> s in <String, _Scenario>{
          ..._tabletScenarios,
          for (final String name in _tabletPhoneScenarios)
            name: _scenarios[name]!,
        }.entries) {
          testWidgets(
            s.key,
            (WidgetTester tester) => _runScenario(tester, env, s),
          );
        }
      });
    }
  }
}

/// Runs scenario [s] at [env] and fails with every problem it found.
Future<void> _runScenario(
  WidgetTester tester,
  _Env env,
  MapEntry<String, _Scenario> s,
) async {
  _problems.clear();
  _tag = env.tag;
  try {
    await s.value(tester, env);
  } on Object catch (e, st) {
    final String at = st
        .toString()
        .split('\n')
        .firstWhere(
          (String l) => l.contains('text_fit_test') && !l.contains('_tap'),
          orElse: () => '',
        );
    _problems.add(
      '$_tag scenario error: ${_oneLine('$e').split('  ').first}'
      ' ${at.trim()}  [${s.key}]',
    );
  }
  expect(_problems, isEmpty, reason: _problems.join('\n'));
}

/// The phone scenarios that also run on tablets as they are.
const List<String> _tabletPhoneScenarios = <String>[
  'palette: base, harmonies, scenarios, save dialog',
  'palette: from a photo, close markers',
  'match: page, results, recent pick sheet',
  'ideas: list, idea of the day, tabs and detail sheets',
  'ideas: diary list, entry form, pickers and photo viewer',
  'settings: backup file',
  'settings: OpenRouter, model sheets, dialogs',
  'settings: Language row and picker',
  'collection: Ohuhu series, sets, older sets and the marker list',
  'collection: printable swatch chart card, all brands and the empty state',
  'onboarding: every step of all brands',
];

/// Tablet versions of the phone scenarios that depend on the layout: the
/// shell has a rail, and a wide Swatches page opens the detail in a pane.
final Map<String, _Scenario> _tabletScenarios = <String, _Scenario>{
  'shell: five tabs and the rail': (WidgetTester tester, _Env env) async {
    _size(tester, env);
    useDeviceLocales(tester, <Locale>[env.locale]);
    await tester.pumpWidget(
      AppScope.inMemory(markers: _markers(), child: const InkLabApp()),
    );
    await tester.pumpAndSettle();
    _check(tester, 'swatches tab');
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(InkNavigationBar), findsNothing);
    for (int i = 0; i < 5; i++) {
      await tester.tap(
        find
            .descendant(
              of: find.byType(NavigationRail),
              // The rail's own ink wells subclass InkResponse.
              matching: find.byWidgetPredicate((Widget w) => w is InkResponse),
            )
            .at(i),
      );
      await tester.pumpAndSettle();
      _check(tester, 'tab $i');
    }
  },
  'swatches: page and the detail of a marker':
      (WidgetTester tester, _Env env) async {
        await _pump(tester, env, SwatchesPage(onBlendingChain: (_) {}));
        _check(tester, 'swatches');
        await _tap(tester, find.textContaining(env.t.swatchesFilters));
        _check(tester, 'filters sheet');
        await _close(tester);
        await _tap(tester, find.text(env.t.swatchesAllFilter));
        final Finder swatch = find.text('B08');
        await tester.scrollUntilVisible(
          swatch,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await _tap(tester, swatch);
        _check(tester, 'swatch detail');
        final Finder detail = find.byWidgetPredicate(
          (Widget w) => w is InkSheet || w is InkDetailPane,
        );
        expect(detail, findsOneWidget);
        await _tap(
          tester,
          find.byKey(const ValueKey<String>('swatch-alternatives')),
        );
        _check(tester, 'swatch detail, alternatives open');
        await _tap(
          tester,
          find.descendant(
            of: detail,
            matching: find.byTooltip(env.t.commonMoreActions),
          ),
        );
        _check(tester, 'swatch detail, menu open');
      },
};
