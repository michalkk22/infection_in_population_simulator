import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';

class Population {
  late IndividualCollection _individuals;

  Population(IndividualCollection individuals) {
    _individuals = individuals;
  }
}
