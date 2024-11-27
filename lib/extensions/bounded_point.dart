import 'dart:math';

extension BoundedPoint on Point<double> {
  Point<double> bounded(double width, double height) {
    return Point<double>(
      x.clamp(0, width - 1),
      y.clamp(0, height - 1),
    );
  }
}
