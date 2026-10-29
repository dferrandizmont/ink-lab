/// How close a marker is to a sampled colour, from its CIELAB76 distance.
///
/// The bands are deliberately honest: ΔE76 around 2 is the smallest
/// difference most people notice side by side, above 10 the colours read as
/// different, and above [noCloseMatchThreshold] the marker is not a usable
/// stand-in at all ("No close match").
enum MatchQuality {
  /// ΔE ≤ 2: practically the same colour.
  nearlyExact(2),

  /// ΔE ≤ 5: a small difference, visible side by side.
  veryClose(5),

  /// ΔE ≤ 10: same colour family, clearly different shade.
  close(10),

  /// ΔE ≤ 20: only a rough stand-in.
  rough(noCloseMatchThreshold),

  /// ΔE > 20: not a match.
  far(double.infinity);

  const MatchQuality(this.maxDeltaE);

  /// Upper (inclusive) distance of the band.
  final double maxDeltaE;

  /// Above this distance the app says "No close match in your markers".
  static const double noCloseMatchThreshold = 20;

  static MatchQuality of(double deltaE) =>
      values.firstWhere((MatchQuality q) => deltaE <= q.maxDeltaE);

  /// Whether a match at [deltaE] is close enough to be offered as a match.
  static bool isUsable(double deltaE) => deltaE <= noCloseMatchThreshold;
}
