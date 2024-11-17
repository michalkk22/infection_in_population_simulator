import 'package:infection_in_population_simulator/simulation/individual/individual.dart';

abstract class IndividualCollection {
  void add(Individual individual);
  bool remove(Individual individual);
}
