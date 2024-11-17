import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';

class IndividualList implements IndividualCollection {
  final List<Individual> _collection = List<Individual>.empty();

  @override
  void add(Individual individual) {
    _collection.add(individual);
  }

  @override
  bool remove(Individual individual) {
    return _collection.remove(individual);
  }
}
