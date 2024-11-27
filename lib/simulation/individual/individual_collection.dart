import 'package:infection_in_population_simulator/simulation/individual/individual.dart';

abstract class IndividualCollection {
  Iterable<Individual> get individuals;

  void add(Individual individual);
  bool remove(Individual individual);

  void update();
}
