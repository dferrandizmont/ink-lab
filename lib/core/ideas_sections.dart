import 'ideas_engine.dart';

/// A run of ideas under one heading of the Ideas tab: a difficulty inside
/// Techniques, Colour challenges and Moods, a season (or "any time") inside
/// Seasons.
final class IdeaSection {
  const IdeaSection({
    required this.presets,
    this.difficulty,
    this.season,
    this.anyTime = false,
  });

  final List<IdeaPreset> presets;

  /// Set for the sections of a difficulty-grouped category.
  final IdeaDifficulty? difficulty;

  /// Set for the sections of a season; null with [anyTime] for the ideas that
  /// belong to no season.
  final IdeaSeason? season;

  /// The "Any time" section of Seasons.
  final bool anyTime;

  /// Stable id for keys and tests: `easy`, `season-autumn`, `any-time`.
  String get id {
    if (difficulty != null) return difficulty!.name;
    if (season != null) return 'season-${season!.name}';
    return 'any-time';
  }
}

/// The season of the northern hemisphere that [date] falls in:
/// March to May spring, June to August summer, September to November autumn,
/// December to February winter.
IdeaSeason ideaSeasonOf(DateTime date) => switch (date.month) {
  3 || 4 || 5 => IdeaSeason.spring,
  6 || 7 || 8 => IdeaSeason.summer,
  9 || 10 || 11 => IdeaSeason.autumn,
  _ => IdeaSeason.winter,
};

/// All four seasons, the one [today] is in first and then the following ones
/// in calendar order (in November: autumn, winter, spring, summer).
List<IdeaSeason> ideaSeasonOrder(DateTime today) {
  final int start = IdeaSeason.values.indexOf(ideaSeasonOf(today));
  return <IdeaSeason>[
    for (int i = 0; i < IdeaSeason.values.length; i++)
      IdeaSeason.values[(start + i) % IdeaSeason.values.length],
  ];
}

/// Splits [presets] (all from [category]) into the headed sections of that
/// category's tab, in the order they are shown; empty sections are dropped.
/// The order of the ideas inside a section is the catalogue order.
List<IdeaSection> ideaSectionsFor(
  IdeaCategory category,
  List<IdeaPreset> presets, {
  required DateTime today,
}) {
  if (category == IdeaCategory.season) {
    return <IdeaSection>[
      for (final IdeaSeason season in ideaSeasonOrder(today))
        if (presets.any((IdeaPreset p) => p.season == season))
          IdeaSection(
            season: season,
            presets: <IdeaPreset>[
              for (final IdeaPreset p in presets)
                if (p.season == season) p,
            ],
          ),
      if (presets.any((IdeaPreset p) => p.season == null))
        IdeaSection(
          anyTime: true,
          presets: <IdeaPreset>[
            for (final IdeaPreset p in presets)
              if (p.season == null) p,
          ],
        ),
    ];
  }
  return <IdeaSection>[
    for (final IdeaDifficulty difficulty in IdeaDifficulty.values)
      if (presets.any((IdeaPreset p) => p.difficulty == difficulty))
        IdeaSection(
          difficulty: difficulty,
          presets: <IdeaPreset>[
            for (final IdeaPreset p in presets)
              if (p.difficulty == difficulty) p,
          ],
        ),
  ];
}
