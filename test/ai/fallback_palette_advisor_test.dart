import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;
import 'package:ink_lab/core/palette_generator.dart';

import 'ai_test_support.dart';

/// Advisor that returns a canned outcome or throws it, never doing I/O.
final class _FakeAdvisor implements PaletteAdvisor {
  _FakeAdvisor(this.outcome);

  final Object outcome;

  @override
  Future<PaletteAdvice> advise(PaletteAdvisorRequest request) async {
    final value = outcome;
    return value is PaletteAdvice ? value : throw value;
  }
}

void main() {
  final base = collection.first;
  final request = PaletteAdvisorRequest(
    availableColors: collection,
    baseColor: base,
    paletteSize: 3,
    mode: PaletteMode.recommended,
    brand: MarkerBrand.ohuhuOahu,
  );

  test('passes through a successful AI result unchanged', () async {
    final primary = _FakeAdvisor(
      PaletteAdviceSuccess([PaletteSuggestion(color: base, reason: 'ai')]),
    );
    final advisor = FallbackPaletteAdvisor(
      primary: primary,
      local: const PaletteGenerator(),
    );

    final result = await advisor.advise(request);

    final success = result as PaletteAdviceSuccess;
    expect(success.usedFallback, isFalse);
    expect(success.suggestions.single.reason, 'ai');
  });

  test('returns the local result with a note when the AI fails', () async {
    final primary = _FakeAdvisor(
      PaletteAdviceFailure(PaletteFailureReason.unauthorized),
    );
    final advisor = FallbackPaletteAdvisor(
      primary: primary,
      local: const PaletteGenerator(),
    );

    final result = await advisor.advise(request);

    final success = result as PaletteAdviceSuccess;
    expect(success.usedFallback, isTrue);
    expect(success.suggestions, isNotEmpty);
    expect(success.tips.single, contains('local suggestions'));
  });

  test('returns the local result when the AI throws', () async {
    final primary = _FakeAdvisor(StateError('boom'));
    final advisor = FallbackPaletteAdvisor(
      primary: primary,
      local: const PaletteGenerator(),
    );

    final result = await advisor.advise(request);

    expect(result, isA<PaletteAdviceSuccess>());
  });

  test('maps a local failure when there is nothing to fall back to', () async {
    final primary = _FakeAdvisor(
      PaletteAdviceFailure(PaletteFailureReason.networkError),
    );
    final advisor = FallbackPaletteAdvisor(
      primary: primary,
      local: const PaletteGenerator(),
    );

    final result = await advisor.advise(
      PaletteAdvisorRequest(
        availableColors: const [],
        paletteSize: 3,
        mode: PaletteMode.recommended,
        brand: MarkerBrand.ohuhuOahu,
      ),
    );

    expect(result, isA<PaletteAdviceFailure>());
    expect(
      (result as PaletteAdviceFailure).reason,
      PaletteFailureReason.noAvailableColors,
    );
  });
}
