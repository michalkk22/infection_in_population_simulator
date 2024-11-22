import 'dart:math';

extension BoundedPoint on Point {
  Point bounded(double width, double height) {
    return Point(
      x.clamp(0, width - 1),
      y.clamp(0, height - 1),
    );
  }
}
