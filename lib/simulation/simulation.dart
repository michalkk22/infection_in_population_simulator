import 'dart:async';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/population.dart';
import 'package:infection_in_population_simulator/constants/simulation_config.dart';

class Simulation {
  final Population _population;
  final Duration _tickDuration;
  late final Timer _timer;

  Simulation({
    required Population population,
    Duration tickDuration = SimulationConfig.tickDuration,
  })  : _tickDuration = tickDuration,
        _population = population;

  void start(void Function() onTick) {
    _timer = Timer.periodic(_tickDuration, (_) {
      _population.update();
      onTick();
    });
  }

  void stop() {
    _timer.cancel();
  }

  Iterable<Individual> get individuals => _population.individuals;
}
