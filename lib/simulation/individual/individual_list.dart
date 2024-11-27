import 'dart:math';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';

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
    List<Individual> toRemove = List.empty(growable: true);
    for (var individual in _collection) {
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
