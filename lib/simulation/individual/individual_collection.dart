import 'dart:math';

import 'package:infection_in_population_simulator/simulation/individual/individual.dart';

abstract class IndividualCollection {
  Iterable<Point<double>> get points;

  void add(Individual individual);
  bool remove(Individual individual);

  void update();
}
