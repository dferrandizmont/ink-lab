import 'package:ink_lab/core/models.dart';

MarkerColor color(
  String code,
  String hex, {
  String brandId = 'ohuhu_oahu',
  List<String> sets = const ['classic_40'],
}) => MarkerColor(
  brandId: brandId,
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: hex,
  sets: sets,
);

final harmonyColors = [
  color('base', 'ff0000'),
  color('opposite', '00ffff'),
  color('nearA', 'ff7700'),
  color('nearB', 'ff0077'),
  color('splitA', '00ff80'),
  color('splitB', '0080ff'),
  color('triadA', '00ff00'),
  color('triadB', '0000ff'),
  color('squareA', '7ffe00'),
  color('rectangleA', 'fefe00'),
  color('mono', 'cc0000'),
  color('shadow', 'c20000'),
  color('neutral', '888888'),
  color('highlight', 'ffeeee'),
];
