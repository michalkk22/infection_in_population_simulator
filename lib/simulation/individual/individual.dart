import 'dart:math';

import 'package:infection_in_population_simulator/constants/simulation_area.dart';
import 'package:infection_in_population_simulator/extensions/bounded_point.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_state/individual_state.dart';
import 'package:infection_in_population_simulator/simulation/vector.dart';

class Individual {
  Point position;
  Vector vector;
  IndividualState state;

  Individual({
    required this.position,
    required this.vector,
    required this.state,
  });

  @override
  int get hashCode => Object.hash(position, vector, state);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Individual) return false;
    return other.position == position &&
        other.vector == vector &&
        other.state == state;
  }

  void move() {
    position = Point(
      position.x + vector.x,
      position.y + vector.y,
    ).bounded(SimulationArea.width, SimulationArea.height);
  }
}
