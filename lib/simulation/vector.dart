import 'dart:math';

class Vector {
  double x;
  double y;

  Vector({
    required this.x,
    required this.y,
  });

//TODO factory random

  double abs() {
    return sqrt(x * x + y * y);
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Vector) return false;
    return other.x == x && other.y == y;
  }

  @override
  String toString() {
    return '($x; $y)';
  }
}
