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
    Random random = SingleRandom().random();
    return Vector(
      x: random.nextDouble() * 2 - 1,
      y: random.nextDouble() * 2 - 1,
    );
  }

  void norm({double to = 1}) {
    double length = abs();
    x = x / length * to;
    y = y / length * to;
  }

  void next() {
    Random random = SingleRandom().random();
    x += random.nextDouble() * 0.2 - 0.1;
    y += random.nextDouble() * 0.2 - 0.1;
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
