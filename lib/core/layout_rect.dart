/// A plain rectangle in pixels, for layouts that must stay pure Dart (no
/// `dart:ui`): the image layouts of sharing and printing live in `core/` so
/// they can be tested without a renderer.
final class LayoutRect {
  const LayoutRect(this.left, this.top, this.width, this.height);

  final double left, top, width, height;

  double get right => left + width;
  double get bottom => top + height;

  /// Whether the two rectangles share any area (touching edges do not count).
  bool overlaps(LayoutRect other) =>
      left < other.right &&
      other.left < right &&
      top < other.bottom &&
      other.top < bottom;

  /// Whether [other] lies entirely inside this rectangle.
  bool contains(LayoutRect other) =>
      other.left >= left &&
      other.top >= top &&
      other.right <= right &&
      other.bottom <= bottom;

  /// This rectangle shrunk by [by] on every side.
  LayoutRect deflate(double by) =>
      LayoutRect(left + by, top + by, width - 2 * by, height - 2 * by);

  @override
  bool operator ==(Object other) =>
      other is LayoutRect &&
      other.left == left &&
      other.top == top &&
      other.width == width &&
      other.height == height;

  @override
  int get hashCode => Object.hash(left, top, width, height);

  @override
  String toString() => 'LayoutRect($left, $top, $width x $height)';
}
