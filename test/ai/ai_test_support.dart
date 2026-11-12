import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ink_lab/core/models.dart';

/// A synthetic Ohuhu colour in the default active set (`classic_160`), so the
/// collection filter accepts it without extra configuration.
MarkerColor marker(String code, String hex) => MarkerColor(
  brandId: MarkerBrand.ohuhuOahu.id,
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: hex,
  sets: const ['classic_160'],
);

final List<MarkerColor> collection = [
  marker('B315', '0a0a0a'),
  marker('R101', 'ff0000'),
  marker('G202', '00ff00'),
  marker('B303', '0000ff'),
  marker('Y404', 'ffff00'),
  marker('N505', '777777'),
];

/// A marker of the brand that the user does not own: it is never a
/// candidate, so it can never be the base of a palette.
MarkerColor markerOutsideCollection() => MarkerColor(
  brandId: MarkerBrand.ohuhuOahu.id,
  newCode: 'Z999',
  newName: 'Name Z999',
  oldCode: 'Z999',
  oldName: 'Name Z999',
  hex: '123456',
  sets: const <String>[],
);

/// The owned set of the fixture collection.
///
/// A request says which markers the user owns, and the engines take only
/// those: without this in the request they have nothing to work with (there
/// is no fallback to the whole range any more).
const Set<String> collectionSetIds = <String>{'classic_160'};

/// JSON body of a successful chat completion whose assistant content is [text].
http.Response completionResponse(
  String text, {
  int status = 200,
  String finishReason = 'stop',
}) => jsonResponse({
  'choices': [
    {
      'message': {'role': 'assistant', 'content': text},
      'finish_reason': finishReason,
    },
  ],
}, status: status);

/// JSON body of an OpenRouter error envelope.
http.Response errorResponse(String message, int status) => jsonResponse({
  'error': {'message': message},
}, status: status);

http.Response jsonResponse(Object body, {int status = 200}) => http.Response(
  jsonEncode(body),
  status,
  headers: {'content-type': 'application/json'},
);

/// Serializes a palette envelope the way the model is asked to.
String paletteJson(
  List<Map<String, String>> palette, {
  List<String> tips = const [],
}) => jsonEncode({'palette': palette, 'tips': tips});
