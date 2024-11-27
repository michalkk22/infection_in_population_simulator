import 'dart:math';

import 'package:infection_in_population_simulator/utils/single_random.dart';

class Vector {
  double x;
  double y;

  Vector({
    required this.x,
    required this.y,
  });

  factory Vector.random() {
    Random random = SingleRandom().random;
    return Vector(
      x: random.nextDouble() * 2 - 1,
      y: random.nextDouble() * 2 - 1,
    );
  }

  factory Vector.randomNorm({double to = 1}) {
    Vector vector = Vector.random();
    vector.norm(to: to);
    return vector;
  }

  factory Vector.randomConstrained({
    double top = 1,
    double bottom = 1,
    double left = 1,
    double right = 1,
    double length = 1,
  }) {
    Random random = SingleRandom().random;
    Vector vector = Vector(
      x: random.nextDouble() * (right + left) - left,
      y: random.nextDouble() * (bottom + top) - top,
    );
    vector.norm(to: length);
    return vector;
  }

  void norm({double to = 1}) {
    double length = abs();
    x = x / length * to;
    y = y / length * to;
  }

  void next({double length = 1}) {
    Random random = SingleRandom().random;
    x += random.nextDouble() * 0.2 - 0.1;
    y += random.nextDouble() * 0.2 - 0.1;
    norm(to: length);
  }

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
