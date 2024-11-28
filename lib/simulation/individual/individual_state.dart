import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/utils/single_random.dart';

abstract class IndividualState {
  Color get color;

  List<Individual> handle(Individual self, Iterable<Individual>? neighbors);
  IndividualState? transition();
  IndividualState thisState();
}

abstract class IndividualStateHealthy extends IndividualState {}

class IndividualStateImmune extends IndividualStateHealthy {
  @override
  Color get color => SimulationConfig.stateImmuneColor;

  @override
  List<Individual> handle(Individual self, Iterable<Individual>? neighbors) =>
      [];

  @override
  IndividualState? transition() => null;

  @override
  IndividualState thisState() => IndividualStateImmune();
}

class IndividualStateSusceptible extends IndividualStateHealthy {
  @override
  Color get color => SimulationConfig.stateSusceptibleColor;

  @override
  List<Individual> handle(Individual self, Iterable<Individual>? neighbors) =>
      [];

  @override
  IndividualState? transition() => SingleRandom().random.nextBool()
      ? IndividualStateInfected()
      : IndividualStateSymptoms();

  @override
  IndividualState thisState() => IndividualStateSusceptible();
}

class IndividualStateInfected extends IndividualState {
  @override
  Color get color => SimulationConfig.stateInfectedColor;

  static const int notInfecting = -1;
  Map<Individual, int> others = {};

  @override
  List<Individual> handle(Individual self, Iterable<Individual>? neighbors) {
    List<Individual> toChange = [];
    // infect
    if (neighbors != null && neighbors.isNotEmpty) {
      toChange.addAll(_handleNeighbors(self, neighbors));
    }
    // recover
    if (--ticksTillRecover <= 0) toChange.add(self);
    return toChange;
  }

  List<Individual> _handleNeighbors(
      Individual self, Iterable<Individual> neighbors) {
    /// returnes individuals to change
    ///

    // clean-up
    others.removeWhere((key, value) =>
        key.state is! IndividualStateSusceptible || !neighbors.contains(key));
    // put absent neighbors and decide now if will be infected
    for (var neighbor in neighbors) {
      if (neighbor.state is IndividualStateSusceptible) {
        others.putIfAbsent(neighbor, () => willInfect() ? 0 : notInfecting);
      }
    }

    // check range and update counter
    others.updateAll((key, value) {
      if (value != notInfecting && inRange(self, key)) {
        return value + 1;
      }
      return notInfecting;
    });

    // return infected
    List<Individual> toChange = [];
    others.forEach(
      (key, value) {
        if (value >= ticksToInfect) {
          toChange.add(key);
          // print('me at: ${self.position} added to infect him at: ${key.position}');
        }
      },
    );
    return toChange;
  }

  bool inRange(Individual a, Individual b) {
    return (a.position - b.position).magnitude <=
        SimulationConfig.infectionRange;
  }

  bool willInfect() {
    return SingleRandom().random.nextBool();
  }

  double ticksTillRecover = (SimulationConfig.minRecoverySeconds +
          (SingleRandom().random.nextDouble() *
              (SimulationConfig.maxRecoverySeconds -
                  SimulationConfig.minRecoverySeconds))) *
      (1000 / SimulationConfig.tickDuration.inMilliseconds);

  final double ticksToInfect = SimulationConfig.secondsToInfect *
      (1000 / SimulationConfig.tickDuration.inMilliseconds);

  @override
  IndividualState? transition() => IndividualStateImmune();

  @override
  IndividualState thisState() => IndividualStateInfected();
}

class IndividualStateSymptoms extends IndividualStateInfected {
  @override
  Color get color => SimulationConfig.stateSymptomsColor;

  @override
  bool willInfect() => true;

  @override
  IndividualState thisState() => IndividualStateSymptoms();
}
