import 'dart:async';
import 'dart:math';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_list.dart';
import 'package:infection_in_population_simulator/simulation/population.dart';
import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/simulation/simulation_memento.dart';
import 'package:infection_in_population_simulator/simulation/vector.dart';

class Simulation {
  Population _population;
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

  SimulationMemento createMemento() {
    List<Individual> saved = [];
    for (var i in individuals) {
      saved.add(Individual(
        position: Point(i.position.x, i.position.y),
        vector: Vector(x: i.vector.x, y: i.vector.y),
        state: i.state.thisState(),
      ));
    }
    return SimulationMemento(population: saved);
  }

  void restoreMemento(SimulationMemento memento) {
    _population = Population(
        IndividualList(collection: List<Individual>.from(memento.population)));
  }
}
