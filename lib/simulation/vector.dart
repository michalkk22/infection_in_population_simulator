import 'dart:math';

import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/utils/single_random.dart';

class Vector {
  double x;
  double y;
  final double defaultMaxSpeed = SimulationConfig.oneMeter *
      2.5 /
      100 /
      SimulationConfig.tickDuration.inMilliseconds;

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

  factory Vector.randomNorm({double? length}) {
    Vector vector = Vector.random();
    length ??= SingleRandom().random.nextDouble() * vector.defaultMaxSpeed;
    vector.norm(to: length);
    // print("Vector.randomNorm: (${vector.x},${vector.y}) at $length");
    return vector;
  }

  factory Vector.randomConstrained({
    double top = 1,
    double bottom = 1,
    double left = 1,
    double right = 1,
    double? length,
  }) {
    Random random = SingleRandom().random;
    Vector vector = Vector(
      x: random.nextDouble() * (right + left) - left,
      y: random.nextDouble() * (bottom + top) - top,
    );
    vector.norm(to: length);
    return vector;
  }

  void norm({double? to}) {
    double length = abs();
    to ??= defaultMaxSpeed;
    x = x / length * to;
    y = y / length * to;
  }

  void next() {
    Random random = SingleRandom().random;
    double d = SimulationConfig.nextVectorDeviation;
    x += random.nextDouble() * 2 * d - d;
    y += random.nextDouble() * 2 * d - d;
    double length = abs() + (random.nextDouble() * 2 * d - d);
    norm(to: length.clamp(0, defaultMaxSpeed));
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
