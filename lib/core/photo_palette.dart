import 'dart:math' as math;
import 'dart:typed_data';

import 'color_utils.dart';
import 'model/marker_color.dart';

/// One dominant colour of a photo.
final class PhotoColor {
  const PhotoColor({required this.colorInt, required this.share});

  /// The colour as opaque ARGB (`0xffRRGGBB`).
  final int colorInt;

  /// Share of the sampled pixels that fall in this colour, in `(0, 1]`.
  final double share;
}

/// Dominant colours, most prominent first. Deterministic for the same input.
///
/// The opaque pixels of the photo are sampled (at most [maxSamples] of them,
/// walking the buffer with a stride) and clustered in OKLab. Clusters that
/// sit too close are merged, clusters with a tiny share are dropped, and the
/// most prominent ones are returned. A small vivid accent may take the slot
/// of a redundant tail colour, never that of one of the three most prominent
/// colours. Pixels with an alpha below 128 are ignored; a photo without a
/// single visible pixel gives an empty list.
List<PhotoColor> extractDominantColors(
  Uint8List rgba,
  int width,
  int height, {
  int count = 6,
  int maxSamples = 20000,
}) {
  final wanted = count.clamp(1, 8);
  final samples = _sampleOklab(rgba, width, height, maxSamples);
  if (samples == null) return const <PhotoColor>[];
  // Over-cluster: a couple of extra clusters make the merge step below able
  // to split a broad colour into its real shades.
  final clusters = _cluster(samples, math.min(wanted + 2, samples.count));
  final candidates = _merge(clusters)
      .where((cluster) => cluster.weight >= _minShare)
      .toList();
  return [
    for (final cluster in _select(candidates, wanted))
      PhotoColor(
        colorInt: oklabToRgb(OklabColor(cluster.l, cluster.a, cluster.b))
            .colorInt,
        share: cluster.weight,
      ),
  ];
}

/// One photo colour and the owned marker chosen for it.
final class PhotoMarkerPick {
  const PhotoMarkerPick({
    required this.source,
    required this.marker,
    required this.deltaE,
  });

  /// The photo colour the marker was chosen for.
  final PhotoColor source;

  /// The owned marker that best represents [source].
  final MarkerColor marker;

  /// ΔE76 between [source] and [marker], the same metric the Match page uses.
  final double deltaE;
}

/// Maps [colors] to distinct markers from [owned]; most prominent colour
/// picks first.
///
/// If a colour's nearest marker is taken, it takes its nearest free one.
/// Colours with no marker left are dropped. Empty [owned] gives an empty
/// list. Markers with a malformed hex are skipped, as the Match page does.
/// A marker is free only once: the same colour listed twice in [owned] is
/// one marker, and two brands may share a code without being the same one.
List<PhotoMarkerPick> matchPhotoColorsToMarkers(
  List<PhotoColor> colors,
  List<MarkerColor> owned,
) {
  if (colors.isEmpty || owned.isEmpty) return const <PhotoMarkerPick>[];
  // The CIELAB of every marker, computed once: the closest marker is the one
  // with the smallest ΔE76, exactly like the Match page.
  final labs = <LabColor?>[];
  for (final marker in owned) {
    try {
      labs.add(hexToLab(marker.hex));
    } on FormatException {
      labs.add(null);
    }
  }
  // Markers are told apart by their id, not by their position: the same
  // marker twice in [owned] is still one marker, and two brands may share a
  // code without being the same colour.
  final used = <String>{};
  final picks = <PhotoMarkerPick>[];
  for (final color in colors) {
    final source = colorIntToLab(color.colorInt);
    var best = -1;
    var bestDeltaE = double.infinity;
    for (var i = 0; i < owned.length; i++) {
      final marker = owned[i];
      if (used.contains(marker.colorId)) continue;
      final lab = labs[i];
      if (lab == null) continue;
      final deltaE = deltaE76(source, lab);
      if (deltaE < bestDeltaE) {
        bestDeltaE = deltaE;
        best = i;
      }
    }
    if (best < 0) break; // no marker left for the rest of the colours
    used.add(owned[best].colorId);
    picks.add(
      PhotoMarkerPick(source: color, marker: owned[best], deltaE: bestDeltaE),
    );
  }
  return picks;
}

/// Clusters closer than this in OKLab are merged into a single colour.
const double _mergeDistance = 0.06;

/// Clusters below this share of the sampled pixels are dropped.
const double _minShare = 0.02;

/// Chroma above which a cluster counts as a vivid accent.
const double _vividChroma = 0.12;

/// Chroma below which a cluster counts as a near-grey.
const double _greyChroma = 0.06;

/// How many of the most prominent clusters never give their slot away.
const int _protectedSlots = 3;

/// Iterations of the k-means refinement.
const int _maxIterations = 12;

/// Centroid movement under which the refinement stops.
const double _convergence = 1e-4;

/// The opaque pixels of a photo, in OKLab.
final class _Samples {
  _Samples(int capacity)
    : l = Float64List(capacity),
      a = Float64List(capacity),
      b = Float64List(capacity);

  final Float64List l;
  final Float64List a;
  final Float64List b;

  /// How many samples were kept; transparent pixels are left out.
  int count = 0;
}

/// A cluster of samples, with its centroid in OKLab.
final class _Cluster {
  _Cluster(this.l, this.a, this.b, this.weight);

  /// Centroid in OKLab.
  double l, a, b;

  /// Share of the sampled pixels in the cluster.
  double weight;

  /// Chroma of the centroid: how saturated the colour is.
  double get chroma => math.sqrt(a * a + b * b);
}

/// The k-means centroids, one per cluster.
final class _Centers {
  _Centers(this.k) : l = Float64List(k), a = Float64List(k), b = Float64List(k);

  final int k;
  final Float64List l;
  final Float64List a;
  final Float64List b;
}

/// Linear sRGB for every 8-bit channel value, built once.
final Float64List _linearChannels = _buildLinearChannels();

Float64List _buildLinearChannels() {
  final table = Float64List(256);
  for (var i = 0; i < 256; i++) {
    table[i] = linearizeSrgbChannel(i / 255);
  }
  return table;
}

/// Cube root, mirroring `rgbToOklab` so both read a colour the same way.
double _cbrt(double value) => value.sign * math.pow(value.abs(), 1 / 3);

/// Reads the opaque pixels of the photo into OKLab buffers.
///
/// Returns null when the photo has no visible pixel. The pixels are read with
/// a stride so at most [maxSamples] of them are converted.
_Samples? _sampleOklab(Uint8List rgba, int width, int height, int maxSamples) {
  if (width <= 0 || height <= 0 || rgba.isEmpty) return null;
  final pixels = math.min(width * height, rgba.length ~/ 4);
  if (pixels <= 0) return null;
  final limit = math.max(1, maxSamples);
  final step = pixels <= limit ? 1 : (pixels / limit).ceil();
  final samples = _Samples((pixels + step - 1) ~/ step);
  for (var pixel = 0; pixel < pixels; pixel += step) {
    final offset = pixel * 4;
    if (rgba[offset + 3] < 128) continue; // transparent pixels are ignored
    final r = _linearChannels[rgba[offset]];
    final g = _linearChannels[rgba[offset + 1]];
    final blue = _linearChannels[rgba[offset + 2]];
    final l = _cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * blue);
    final m = _cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * blue);
    final s = _cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * blue);
    samples.l[samples.count] =
        0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s;
    samples.a[samples.count] =
        1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s;
    samples.b[samples.count] =
        0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s;
    samples.count++;
  }
  return samples.count == 0 ? null : samples;
}

/// Groups the samples into at most [k] clusters with k-means.
///
/// The seeding is farthest-point: the first centre is the sample closest to
/// the average colour and every other centre is the sample farthest from the
/// centres picked so far. Like k-means++ with a fixed seed it is fully
/// deterministic, and it does not depend on the random number generator.
List<_Cluster> _cluster(_Samples samples, int k) {
  final n = samples.count;
  final centers = _seedCenters(samples, k);
  final sumL = Float64List(k);
  final sumA = Float64List(k);
  final sumB = Float64List(k);
  final counts = Int32List(k);
  for (var iteration = 0; iteration < _maxIterations; iteration++) {
    sumL.fillRange(0, k, 0);
    sumA.fillRange(0, k, 0);
    sumB.fillRange(0, k, 0);
    counts.fillRange(0, k, 0);
    for (var s = 0; s < n; s++) {
      final l = samples.l[s];
      final a = samples.a[s];
      final b = samples.b[s];
      var best = 0;
      var bestDistance = double.infinity;
      for (var c = 0; c < k; c++) {
        final distance = _squaredDistance(
          l,
          a,
          b,
          centers.l[c],
          centers.a[c],
          centers.b[c],
        );
        if (distance < bestDistance) {
          bestDistance = distance;
          best = c;
        }
      }
      sumL[best] += l;
      sumA[best] += a;
      sumB[best] += b;
      counts[best]++;
    }
    var moved = 0.0;
    for (var c = 0; c < k; c++) {
      if (counts[c] == 0) continue;
      final l = sumL[c] / counts[c];
      final a = sumA[c] / counts[c];
      final b = sumB[c] / counts[c];
      final move = _distance(centers.l[c], centers.a[c], centers.b[c], l, a, b);
      if (move > moved) moved = move;
      centers.l[c] = l;
      centers.a[c] = a;
      centers.b[c] = b;
    }
    if (moved < _convergence) break;
  }
  final clusters = <_Cluster>[];
  for (var c = 0; c < k; c++) {
    if (counts[c] == 0) continue; // empty cluster
    clusters.add(
      _Cluster(centers.l[c], centers.a[c], centers.b[c], counts[c] / n),
    );
  }
  return clusters;
}

/// Picks the starting centres of the k-means refinement.
_Centers _seedCenters(_Samples samples, int k) {
  final n = samples.count;
  final centers = _Centers(k);
  var meanL = 0.0;
  var meanA = 0.0;
  var meanB = 0.0;
  for (var s = 0; s < n; s++) {
    meanL += samples.l[s];
    meanA += samples.a[s];
    meanB += samples.b[s];
  }
  meanL /= n;
  meanA /= n;
  meanB /= n;
  // The first centre is the sample closest to the average colour: a central
  // and representative one, instead of whatever pixel comes first.
  var first = 0;
  var firstDistance = double.infinity;
  for (var s = 0; s < n; s++) {
    final distance = _squaredDistance(
      samples.l[s],
      samples.a[s],
      samples.b[s],
      meanL,
      meanA,
      meanB,
    );
    if (distance < firstDistance) {
      firstDistance = distance;
      first = s;
    }
  }
  centers.l[0] = samples.l[first];
  centers.a[0] = samples.a[first];
  centers.b[0] = samples.b[first];
  // Distance of every sample to the closest centre so far.
  final closest = Float64List(n);
  for (var s = 0; s < n; s++) {
    closest[s] = _squaredDistance(
      samples.l[s],
      samples.a[s],
      samples.b[s],
      centers.l[0],
      centers.a[0],
      centers.b[0],
    );
  }
  for (var c = 1; c < k; c++) {
    var far = 0;
    var farDistance = -1.0;
    for (var s = 0; s < n; s++) {
      if (closest[s] > farDistance) {
        farDistance = closest[s];
        far = s;
      }
    }
    centers.l[c] = samples.l[far];
    centers.a[c] = samples.a[far];
    centers.b[c] = samples.b[far];
    for (var s = 0; s < n; s++) {
      final distance = _squaredDistance(
        samples.l[s],
        samples.a[s],
        samples.b[s],
        centers.l[c],
        centers.a[c],
        centers.b[c],
      );
      if (distance < closest[s]) closest[s] = distance;
    }
  }
  return centers;
}

/// Merges the clusters that are closer than [_mergeDistance].
///
/// The centroid of the merged cluster is the average of both, weighted by
/// their share, so a small cluster never drags a big one around.
List<_Cluster> _merge(List<_Cluster> clusters) {
  final merged = List<_Cluster>.of(clusters);
  while (merged.length > 1) {
    var bestI = 0;
    var bestJ = 0;
    var bestDistance = _mergeDistance;
    for (var i = 0; i < merged.length; i++) {
      for (var j = i + 1; j < merged.length; j++) {
        final distance = _distance(
          merged[i].l,
          merged[i].a,
          merged[i].b,
          merged[j].l,
          merged[j].a,
          merged[j].b,
        );
        if (distance < bestDistance) {
          bestDistance = distance;
          bestI = i;
          bestJ = j;
        }
      }
    }
    if (bestDistance >= _mergeDistance) break;
    final first = merged[bestI];
    final second = merged[bestJ];
    final total = first.weight + second.weight;
    first.l = (first.l * first.weight + second.l * second.weight) / total;
    first.a = (first.a * first.weight + second.a * second.weight) / total;
    first.b = (first.b * first.weight + second.b * second.weight) / total;
    first.weight = total;
    merged.removeAt(bestJ);
  }
  return merged;
}

/// Keeps the [count] most prominent clusters, most prominent first.
///
/// The dominant colours come first by share, but a small yet strongly
/// chromatic cluster (an orange accent on a beige photo) must not lose its
/// slot to a near-grey: a vivid cluster takes the place of the weakest
/// near-grey of the tail. The score `share * (1 + 2 * chroma)` ranks the
/// clusters of the same kind, so saturated colours win the ties.
///
/// An accent never takes the slot of one of the [_protectedSlots] most
/// prominent clusters, so the colours that carry the photo are always kept.
/// It only replaces a redundant tail colour: a near-grey first, otherwise
/// the tail colour that repeats a kept colour the most.
List<_Cluster> _select(List<_Cluster> candidates, int count) {
  final ranked = _byShare(candidates);
  if (ranked.length <= count) return ranked;
  final selected = ranked.take(count).toList();
  final accents =
      candidates
          .where(
            (cluster) =>
                cluster.chroma > _vividChroma && cluster.weight >= _minShare,
          )
          .toList()
        ..sort((x, y) => _score(y).compareTo(_score(x)));
  // The most prominent clusters, and every accent already placed, are kept.
  final locked = <_Cluster>{...selected.take(_protectedSlots)};
  for (final accent in accents) {
    if (selected.contains(accent)) continue;
    final victim = _accentVictim(selected, accent, locked);
    if (victim < 0) continue; // nothing redundant to give way to the accent
    selected[victim] = accent;
    locked.add(accent);
  }
  return _byShare(selected);
}

/// The slot an [accent] may take in [selected], or -1 when it may take none.
///
/// Only the tail of the palette (the fourth colour and later) may give way:
/// the first [_protectedSlots] colours are the ones that carry the photo.
/// A near-grey goes first, otherwise the tail colour that repeats a kept
/// colour the most is the redundant one. The accent only takes that slot
/// when it stays further away from the kept colours than the colour it
/// replaces, so it adds a separation the palette did not have.
int _accentVictim(
  List<_Cluster> selected,
  _Cluster accent,
  Set<_Cluster> locked,
) {
  final tailStart = math.min(_protectedSlots, selected.length);
  if (tailStart >= selected.length) return -1; // no colour may give way
  // The weakest near-grey of the tail gives way first.
  var victim = -1;
  for (var i = tailStart; i < selected.length; i++) {
    final cluster = selected[i];
    if (locked.contains(cluster)) continue;
    if (cluster.chroma >= _greyChroma) continue;
    if (victim < 0 || cluster.weight < selected[victim].weight) victim = i;
  }
  if (victim >= 0) return victim;
  // Otherwise the most redundant colour of the tail goes: the one that
  // repeats a kept colour the most in the OKLab a/b plane.
  var victimDistance = double.infinity;
  for (var i = tailStart; i < selected.length; i++) {
    final cluster = selected[i];
    if (locked.contains(cluster)) continue;
    final distance = _nearestChromaDistance(cluster, locked);
    if (distance < victimDistance) {
      victimDistance = distance;
      victim = i;
    }
  }
  if (victim < 0) return -1;
  // The accent must add a separation the redundant colour did not have.
  if (_nearestChromaDistance(accent, locked) <= victimDistance) return -1;
  return victim;
}

/// The distance in the OKLab a/b plane from [cluster] to the closest of
/// [others], lightness aside.
double _nearestChromaDistance(_Cluster cluster, Iterable<_Cluster> others) {
  var nearest = double.infinity;
  for (final other in others) {
    final da = cluster.a - other.a;
    final db = cluster.b - other.b;
    final distance = math.sqrt(da * da + db * db);
    if (distance < nearest) nearest = distance;
  }
  return nearest;
}

/// Sorts the clusters by share, most prominent first, with stable ties.
List<_Cluster> _byShare(List<_Cluster> clusters) {
  final indexed = clusters.indexed.toList();
  indexed.sort((x, y) {
    final byShare = y.$2.weight.compareTo(x.$2.weight);
    if (byShare != 0) return byShare;
    final byScore = _score(y.$2).compareTo(_score(x.$2));
    if (byScore != 0) return byScore;
    return x.$1.compareTo(y.$1);
  });
  return indexed.map((entry) => entry.$2).toList();
}

/// Ranking score of a cluster: its share, boosted by how saturated it is.
double _score(_Cluster cluster) => cluster.weight * (1 + 2 * cluster.chroma);

double _squaredDistance(
  double l1,
  double a1,
  double b1,
  double l2,
  double a2,
  double b2,
) {
  final dl = l1 - l2;
  final da = a1 - a2;
  final db = b1 - b2;
  return dl * dl + da * da + db * db;
}

double _distance(
  double l1,
  double a1,
  double b1,
  double l2,
  double a2,
  double b2,
) => math.sqrt(_squaredDistance(l1, a1, b1, l2, a2, b2));
