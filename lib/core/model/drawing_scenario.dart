import '../json_value.dart';

enum DrawingScenario {
  ghostCharacter('Ghost Character'),
  cuteCharacter('Cute Character'),
  fantasyCreature('Fantasy Creature'),
  warmPortrait('Warm Portrait'),
  coolPortrait('Cool Portrait'),
  sunsetLandscape('Sunset Landscape'),
  forestScene('Forest Scene'),
  oceanScene('Ocean Scene'),
  autumnScene('Autumn Scene'),
  springGarden('Spring Garden'),
  cozyInterior('Cozy Interior'),
  vintageRoom('Vintage Room'),
  pastelDream('Pastel Dream'),
  neonNight('Neon Night'),
  moodyNight('Moody Night'),
  floralPattern('Floral Pattern'),
  geometricPattern('Geometric Pattern'),
  plaidPattern('Plaid Pattern'),
  polkaDotPattern('Polka Dot Pattern'),
  candyStripes('Candy Stripes'),
  halloweenMood('Halloween Mood'),
  christmasMood('Christmas Mood'),
  springMood('Spring Mood'),
  summerMood('Summer Mood'),
  autumnMood('Autumn Mood'),
  winterMood('Winter Mood'),
  winterSnow('Winter Snow');

  const DrawingScenario(this.label);
  final String label;
  String toJson() => enumJson(this);
  static DrawingScenario fromJson(Object? json) => decodeEnum(values, json);
}
