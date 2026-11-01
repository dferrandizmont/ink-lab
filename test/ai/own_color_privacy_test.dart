import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/open_router_palette_advisor.dart';
import 'package:ink_lab/core/models.dart';

MarkerColor marker(String code, String hex) => MarkerColor(
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: hex,
  sets: const ['classic_40'],
);

void main() {
  test('a colour the user read from their own photo is never sent', () {
    final own = marker('R1', 'aa1122').withOwnHex('334455');
    final request = AiPaletteRequest(
      brandId: 'ohuhu_oahu',
      brandLabel: 'Ohuhu',
      baseColor: null,
      candidates: [own, marker('G1', '00ff00')],
      scenario: null,
      mode: PaletteMode.recommended,
      paletteSize: 3,
    );

    final prompt = buildPaletteUserPrompt(request);

    // The model gets the catalogue's colour, the same one everybody has.
    expect(prompt, contains('R1#AA1122'));
    expect(prompt, contains('G1#00FF00'));
    expect(prompt.toLowerCase(), isNot(contains('334455')));
  });
}
