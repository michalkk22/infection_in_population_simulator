import 'dart:math';

import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/extensions/bounded_point.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_state.dart';
import 'package:infection_in_population_simulator/simulation/vector.dart';
import 'package:infection_in_population_simulator/utils/single_random.dart';

class Individual {
  Point<double> position;
  Vector vector;
  IndividualState state;

  Individual({
    required this.position,
    required this.vector,
    required this.state,
  });

  factory Individual.random({
    double maxX = SimulationConfig.width - 1,
    double maxY = SimulationConfig.height - 1,
    IndividualState? state,
  }) {
    final Random random = SingleRandom().random;
    return Individual(
      position: Point<double>(
        random.nextDouble() * maxX,
        random.nextDouble() * maxY,
      ),
      vector: Vector.randomNorm(),
      state: state ?? IndividualStateSusceptible(),
    );
  }

  factory Individual.randomBorder({
    double maxX = SimulationConfig.width - 1,
    double maxY = SimulationConfig.height - 1,
  }) {
    final Random random = SingleRandom().random;
    double rand = random.nextDouble();
    Point<double> position;
    Vector vector;
    double penalty = SimulationConfig.borderVectorPenalty;
    switch (random.nextInt(4)) {
      case 0:
        position = Point(rand * maxX, 0);
        vector = Vector.randomConstrained(top: penalty);
        break;
      case 1:
        vector = Vector.randomConstrained(left: penalty);
        position = Point(0, rand * maxY);
        break;
      case 2:
        vector = Vector.randomConstrained(bottom: penalty);
        position = Point(rand * maxX, maxY);
        break;
      case 3:
        vector = Vector.randomConstrained(right: penalty);
        position = Point(maxX, rand * maxY);
        break;
      default:
        position = const Point(0, 0);
        vector = Vector(x: 0, y: 0);
    }

    IndividualState state;
    if (random.nextInt(10) != 0) {
      state = IndividualStateSusceptible();
    } else {
      if (random.nextBool()) {
        state = IndividualStateInfected();
      } else {
        state = IndividualStateSymptoms();
      }
    }

    return Individual(
      position: position,
      vector: vector,
      state: state,
    );
  }

  void move() {
    position = Point<double>(
      position.x + vector.x,
      position.y + vector.y,
    ).bounded(SimulationConfig.width, SimulationConfig.height);
  }

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

  bool nextOrOut({bool Function()? isOut}) {
    /// Returnes true if decides to go out

    final Random random = SingleRandom().random;
    isOut ??= () => random.nextBool();
    // isOut ??= () {
    //   bool out = random.nextBool();
    //   if (out) print('Out at: (${position.x},${position.y})');
    //   return out;
    // };

    double penalty = SimulationConfig.borderVectorPenalty;

    if (position.x == 0) {
      if (isOut()) return true;
      vector = Vector.randomConstrained(left: penalty);
    } else if (position.y == 0) {
      if (isOut()) return true;
      vector = Vector.randomConstrained(top: penalty);
    } else if (position.x == SimulationConfig.width - 1) {
      if (isOut()) return true;
      vector = Vector.randomConstrained(right: penalty);
    } else if (position.y == SimulationConfig.height - 1) {
      if (isOut()) return true;
      vector = Vector.randomConstrained(bottom: penalty);
    } else {
      vector.next();
    }
    return false;
  }
}
