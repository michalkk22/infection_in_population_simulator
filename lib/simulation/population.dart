import 'dart:math';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';

class Population {
  final IndividualCollection _individuals;

  Population(this._individuals);

  void update() {
    _individuals.update();
    _individuals.add(Individual.randomBorder());
  }

  Iterable<Point<double>> get points => _individuals.points;
}
