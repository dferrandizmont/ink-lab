import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/white_balance.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/pages/match/photo_sampling.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';

import '../../support/l10n.dart';
import 'match_test_support.dart';

const List<int> _paper = <int>[230, 210, 180];
const List<int> _ink = <int>[200, 40, 40];

/// 8x8: warm paper on the left half, a red stroke on the right half.
SampledImage _paperAndInk() => imageFromRgb(8, 8, <List<int>>[
  for (var y = 0; y < 8; y++)
    for (var x = 0; x < 8; x++) x < 4 ? _paper : _ink,
]);

int _int(List<int> rgb) => RgbColor(rgb[0], rgb[1], rgb[2]).colorInt;

Finder get _canvas => find.byKey(const ValueKey<String>('match-canvas'));

/// Taps the left (paper) or the right (ink) half of the photo.
Future<void> _tapHalf(WidgetTester tester, {required bool paper}) async {
  final Rect rect = tester.getRect(_canvas);
  // The 8x8 photo is contained: a square centred in the canvas.
  final double side = rect.height < rect.width ? rect.height : rect.width;
  await tester.tapAt(
    Offset(rect.center.dx + (paper ? -1 : 1) * side / 4, rect.center.dy),
  );
  await tester.pumpAndSettle();
}

Future<void> _pickPhoto(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
  await tester.pumpAndSettle();
}

Future<void> _startWhite(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey<String>('white-balance-start')));
  await tester.pumpAndSettle();
}

String _sampledHex(WidgetTester tester) => tester
    .widget<Text>(find.byKey(const ValueKey<String>('match-sampled-hex')))
    .data!;

Future<AppScope> _pump(WidgetTester tester, SampledImage image) => pumpMatch(
  tester,
  picker: FakeImagePickerService(PhotoPicked(tinyPng)),
  image: image,
);

void main() {
  final WhiteBalance expected = (WhiteBalanceFit.fromReference(
    _int(_paper),
  ) as WhiteBalanceApplied).balance;

  testWidgets('the fix waits for a photo', (tester) async {
    await _pump(tester, _paperAndInk());
    // The row of actions is always the same: the fix is there, disabled.
    final Finder start = find.byKey(
      const ValueKey<String>('white-balance-start'),
    );
    expect(start, findsOneWidget);
    expect(tester.widget<InkButton>(start).onPressed, isNull);

    await _pickPhoto(tester);
    expect(tester.widget<InkButton>(start).onPressed, isNotNull);
  });

  testWidgets('tapping the paper balances every sampled colour', (
    tester,
  ) async {
    await _pump(tester, _paperAndInk());
    await _pickPhoto(tester);

    await _tapHalf(tester, paper: false);
    expect(_sampledHex(tester), '#${colorIntToHex(_int(_ink))}');

    await _startWhite(tester);
    expect(find.text(l10n.matchWhiteBalanceHint), findsOneWidget);
    await _tapHalf(tester, paper: true);

    // The "on" state, and the sample already on screen is taken again.
    expect(find.text(l10n.matchWhiteBalanceOn), findsOneWidget);
    expect(find.text(l10n.matchWhiteBalanceHint), findsNothing);
    expect(
      _sampledHex(tester),
      '#${colorIntToHex(expected.apply(_int(_ink)))}',
    );
    expect(_sampledHex(tester), isNot('#${colorIntToHex(_int(_ink))}'));

    // New samples are balanced too.
    await _tapHalf(tester, paper: true);
    expect(_sampledHex(tester), '#FFFFFF');
  });

  testWidgets('the photo preview is corrected only while the fix is on', (
    tester,
  ) async {
    await _pump(tester, _paperAndInk());
    await _pickPhoto(tester);
    expect(find.byType(ColorFiltered), findsNothing);

    await _startWhite(tester);
    await _tapHalf(tester, paper: true);
    expect(find.byType(ColorFiltered), findsNWidgets(3));
    final PhotoSampleCanvas canvas = tester.widget(
      find.byType(PhotoSampleCanvas),
    );
    expect(canvas.balance, expected);

    await tester.tap(find.byKey(const ValueKey<String>('white-balance-reset')));
    await tester.pumpAndSettle();
    expect(find.byType(ColorFiltered), findsNothing);
    expect(find.text(l10n.matchWhiteBalanceButton), findsOneWidget);
  });

  testWidgets('undoing the fix brings the raw colours back', (tester) async {
    await _pump(tester, _paperAndInk());
    await _pickPhoto(tester);
    await _tapHalf(tester, paper: false);
    await _startWhite(tester);
    await _tapHalf(tester, paper: true);
    expect(_sampledHex(tester), isNot('#${colorIntToHex(_int(_ink))}'));

    await tester.tap(find.byKey(const ValueKey<String>('white-balance-reset')));
    await tester.pumpAndSettle();
    expect(_sampledHex(tester), '#${colorIntToHex(_int(_ink))}');
  });

  testWidgets('a point that is too dark is refused and nothing changes', (
    tester,
  ) async {
    await _pump(
      tester,
      imageFromRgb(8, 8, <List<int>>[
        for (var y = 0; y < 8; y++)
          for (var x = 0; x < 8; x++)
            x < 4 ? <int>[30, 30, 30] : <int>[255, 230, 30],
      ]),
    );
    await _pickPhoto(tester);
    await _startWhite(tester);
    await _tapHalf(tester, paper: true);

    expect(find.text(l10n.matchWhiteBalanceTooDark), findsOneWidget);
    expect(find.text(l10n.matchWhiteBalanceOn), findsNothing);
    expect(find.byType(ColorFiltered), findsNothing);

    // The user can try another point straight away.
    await _tapHalf(tester, paper: false);
    expect(find.text(l10n.matchWhiteBalanceTooColourful), findsOneWidget);
    expect(find.text(l10n.matchWhiteBalanceTooDark), findsNothing);
  });

  testWidgets('choosing can be cancelled', (tester) async {
    await _pump(tester, _paperAndInk());
    await _pickPhoto(tester);
    await _startWhite(tester);
    await tester.tap(
      find.byKey(const ValueKey<String>('white-balance-cancel')),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.matchWhiteBalanceHint), findsNothing);
    expect(find.text(l10n.matchWhiteBalanceButton), findsOneWidget);
    // A tap samples again.
    await _tapHalf(tester, paper: false);
    expect(_sampledHex(tester), '#${colorIntToHex(_int(_ink))}');
  });

  testWidgets('a new photo starts without the fix', (tester) async {
    await _pump(tester, _paperAndInk());
    await _pickPhoto(tester);
    await _startWhite(tester);
    await _tapHalf(tester, paper: true);
    expect(find.text(l10n.matchWhiteBalanceOn), findsOneWidget);

    await _pickPhoto(tester);
    expect(find.text(l10n.matchWhiteBalanceOn), findsNothing);
    expect(find.text(l10n.matchWhiteBalanceButton), findsOneWidget);
  });

  testWidgets('the colours the user stored are the ones matched', (
    tester,
  ) async {
    final AppScope scope = await _pump(
      tester,
      sampledImage(8, 8, <int>[255, 0, 0]),
    );
    await _pickPhoto(tester);
    await _tapHalf(tester, paper: true);

    final String originalBest = tester
        .widget<BestMatchTile>(find.byType(BestMatchTile))
        .match
        .color
        .newCode;
    final String other = tester
        .widget<MatchResultTile>(find.byType(MatchResultTile).first)
        .match
        .color
        .newCode;
    expect(other, isNot(originalBest));
    expect(find.byType(OwnColorMark), findsNothing);

    // The user's own ink of another marker is exactly the sampled red.
    await scope.ownColors.set('ohuhu_oahu:$other', 'ff0000');
    await tester.pumpAndSettle();
    final BestMatchTile best = tester.widget(find.byType(BestMatchTile));
    expect(best.match.color.newCode, other);
    expect(best.match.color.hasOwnColor, isTrue);
    expect(best.match.deltaE, closeTo(0, 0.01));
    expect(find.byType(OwnColorMark), findsOneWidget);

    // Switched off, the catalogue colours are back.
    await scope.settings.setUseOwnColors(false);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<BestMatchTile>(find.byType(BestMatchTile))
          .match
          .color
          .newCode,
      originalBest,
    );
    expect(find.byType(OwnColorMark), findsNothing);
  });
}
