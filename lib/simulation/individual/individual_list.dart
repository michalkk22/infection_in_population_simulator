import 'dart:math';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_state.dart';

class IndividualList implements IndividualCollection {
  final List<Individual> _collection;

  IndividualList({List<Individual>? collection})
      : _collection = collection ?? List<Individual>.empty(growable: true);

  @override
  void add(Individual individual) {
    _collection.add(individual);
  }

  @override
  bool remove(Individual individual) {
    return _collection.remove(individual);
  }

  @override
  void update() {
    List<Individual> toRemove = [];
    IndividualState? newState;
    for (var individual in _collection) {
      // handle state and change others if needed
      List<Individual> toChange = [];
      toChange.addAll(individual.state.handle(individual, _collection));

      if (toChange.isNotEmpty) {
        for (var ind in toChange) {
          newState = ind.state.transition();
          if (newState != null) {
            ind.state = newState;
            if (newState is IndividualStateInfected) {
              // print('got infected at ${ind.position}');
            }
          }
        }
      }

      // move and prepare for next tick
      individual.move();

      if (individual.nextOrOut()) {
        toRemove.add(individual);
        continue;
      }
    }
    for (var individual in toRemove) {
      _collection.remove(individual);
    }
  }

  Iterable<Point<double>> get points => List.generate(
        _collection.length,
        (int i) => _collection[i].position,
        growable: false,
      );

  @override
  String toString() {
    return 'IndividualList(${_collection.length} individuals)';
  }

  @override
  Iterable<Individual> get individuals => _collection;
}
