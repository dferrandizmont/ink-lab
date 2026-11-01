import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/white_balance.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/swatches/own_color_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';
import '../match/match_test_support.dart';

const List<int> _paper = <int>[230, 210, 180];
const List<int> _ink = <int>[40, 120, 200];

SampledImage _paperAndInk() => imageFromRgb(8, 8, <List<int>>[
  for (var y = 0; y < 8; y++)
    for (var x = 0; x < 8; x++) x < 4 ? _paper : _ink,
]);

int _int(List<int> rgb) => RgbColor(rgb[0], rgb[1], rgb[2]).colorInt;

MarkerColor _marker({String hex = 'aa1122', String? catalogHex}) => MarkerColor(
  newCode: 'R1',
  newName: 'Red one',
  oldCode: 'R1',
  oldName: 'Red one',
  hex: hex,
  catalogHex: catalogHex,
  sets: const <String>['classic_160'],
);

/// Opens the page from a button and records what it returns.
class _Host {
  String? result;
  bool returned = false;
}

Future<_Host> _open(
  WidgetTester tester, {
  MarkerColor? color,
  ImagePickerService? picker,
  PhotoDecoder? decoder,
  Size size = const Size(390, 1400),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final _Host host = _Host();
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: () async {
            host.result = await OwnColorPage.open(
              context,
              color ?? _marker(),
              picker: picker,
              decoder: decoder,
            );
            host.returned = true;
          },
          child: const Text('open'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return host;
}

Finder get _hexField => find.byKey(const ValueKey<String>('own-color-hex'));
Finder get _save => find.byKey(const ValueKey<String>('own-color-save'));
Finder get _canvas => find.byKey(const ValueKey<String>('own-color-canvas'));

String _typed(WidgetTester tester) =>
    tester.widget<TextField>(_hexField).controller!.text;

bool _saveEnabled(WidgetTester tester) =>
    tester
        .widget<FilledButton>(
          find.descendant(of: _save, matching: find.byType(FilledButton)),
        )
        .onPressed !=
    null;

Future<void> _tapHalf(WidgetTester tester, {required bool paper}) async {
  final Rect rect = tester.getRect(_canvas);
  final double side = rect.height < rect.width ? rect.height : rect.width;
  await tester.tapAt(
    Offset(rect.center.dx + (paper ? -1 : 1) * side / 4, rect.center.dy),
  );
  await tester.pumpAndSettle();
}

Future<void> _pickPhoto(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey<String>('own-color-gallery')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the catalogue colour and starts from the current one', (
    tester,
  ) async {
    await _open(
      tester,
      color: _marker(hex: '112233', catalogHex: 'aa1122'),
    );

    expect(find.text(l10n.ownColorTitle('R1')), findsOneWidget);
    expect(find.text('#AA1122'), findsOneWidget);
    expect(find.text('#112233'), findsOneWidget);
    expect(_typed(tester), '112233');
  });

  testWidgets('a typed colour is saved and returned', (tester) async {
    final _Host host = await _open(tester);

    await tester.enterText(_hexField, '#3a7f9c');
    await tester.pumpAndSettle();
    expect(_saveEnabled(tester), isTrue);
    expect(find.text('#3A7F9C'), findsOneWidget);
    await tester.ensureVisible(_save);
    await tester.tap(_save);
    await tester.pumpAndSettle();

    expect(host.returned, isTrue);
    expect(host.result, '3a7f9c');
  });

  testWidgets('three digits are accepted, anything else is refused', (
    tester,
  ) async {
    final _Host host = await _open(tester);

    await tester.enterText(_hexField, 'f0a');
    await tester.pumpAndSettle();
    expect(_saveEnabled(tester), isTrue);

    await tester.enterText(_hexField, '12345');
    await tester.pumpAndSettle();
    expect(find.text(l10n.ownColorHexInvalid), findsOneWidget);
    expect(_saveEnabled(tester), isFalse);

    await tester.enterText(_hexField, '');
    await tester.pumpAndSettle();
    expect(find.text(l10n.ownColorHexInvalid), findsNothing);
    expect(_saveEnabled(tester), isFalse);
    expect(host.returned, isFalse);
  });

  testWidgets('only hex digits can be typed', (tester) async {
    await _open(tester);
    await tester.enterText(_hexField, 'zz12xy#3456789');
    await tester.pumpAndSettle();
    expect(_typed(tester), '12#3456');
  });

  testWidgets('leaving without saving returns nothing', (tester) async {
    final _Host host = await _open(tester);
    await tester.enterText(_hexField, '3a7f9c');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(host.returned, isTrue);
    expect(host.result, isNull);
  });

  testWidgets('tapping the painted swatch of a photo sets the colour', (
    tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final _Host host = await _open(
      tester,
      picker: picker,
      decoder: fixedDecoder(_paperAndInk()),
    );
    expect(_canvas, findsNothing);

    await _pickPhoto(tester);
    expect(picker.calls, <PhotoSource>[PhotoSource.gallery]);
    expect(find.text(l10n.ownColorPhotoTap), findsOneWidget);
    await _tapHalf(tester, paper: false);

    expect(_typed(tester), colorIntToHex(_int(_ink)));
    expect(find.text(l10n.ownColorPhotoTap), findsNothing);
    await tester.ensureVisible(_save);
    await tester.tap(_save);
    await tester.pumpAndSettle();
    expect(host.result, colorIntToHex(_int(_ink)).toLowerCase());
  });

  testWidgets('the white balance corrects what is sampled', (tester) async {
    await _open(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      decoder: fixedDecoder(_paperAndInk()),
    );
    await _pickPhoto(tester);
    await _tapHalf(tester, paper: false);
    expect(_typed(tester), colorIntToHex(_int(_ink)));

    await tester.tap(find.byKey(const ValueKey<String>('white-balance-start')));
    await tester.pumpAndSettle();
    await _tapHalf(tester, paper: true);

    final WhiteBalance balance = (WhiteBalanceFit.fromReference(
      _int(_paper),
    ) as WhiteBalanceApplied).balance;
    expect(find.text(l10n.matchWhiteBalanceOn), findsOneWidget);
    expect(_typed(tester), colorIntToHex(balance.apply(_int(_ink))));
    expect(find.byType(ColorFiltered), findsNWidgets(3));

    await tester.tap(find.byKey(const ValueKey<String>('white-balance-reset')));
    await tester.pumpAndSettle();
    expect(_typed(tester), colorIntToHex(_int(_ink)));
    expect(find.byType(ColorFiltered), findsNothing);
  });

  testWidgets('a white that is not paper is refused', (tester) async {
    await _open(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      decoder: fixedDecoder(_paperAndInk()),
    );
    await _pickPhoto(tester);
    await tester.tap(find.byKey(const ValueKey<String>('white-balance-start')));
    await tester.pumpAndSettle();
    // The blue stroke is far too dark and coloured to be paper.
    await _tapHalf(tester, paper: false);

    expect(find.text(l10n.matchWhiteBalanceTooDark), findsOneWidget);
    expect(find.text(l10n.matchWhiteBalanceOn), findsNothing);
  });

  testWidgets('a denied camera says so', (tester) async {
    await _open(
      tester,
      picker: FakeImagePickerService(const PhotoPickDenied(PhotoSource.camera)),
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey<String>('own-color-camera')),
    );
    await tester.tap(find.byKey(const ValueKey<String>('own-color-camera')));
    await tester.pumpAndSettle();
    expect(find.text(l10n.matchCameraDenied), findsOneWidget);
  });

  testWidgets('a photo that cannot be read says so', (tester) async {
    await _open(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      decoder: (_) async => throw const PhotoDecodeException('broken'),
    );
    await _pickPhoto(tester);
    expect(find.text(l10n.matchDecodeFailed), findsOneWidget);
    expect(_canvas, findsNothing);
  });

  testWidgets('the photos stay on the phone, and the page says so', (
    tester,
  ) async {
    await _open(tester);
    expect(find.text(l10n.matchPrivacyCaption), findsOneWidget);
  });
}
