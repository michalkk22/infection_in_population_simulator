import 'package:infection_in_population_simulator/simulation/individual/individual.dart';

class Population {
  final List<Individual> _individuals;

  Population(this._individuals);

  List<Individual> get individuals => _individuals;

  void moveAll() {
    for (var individual in _individuals) {
      individual.move();
    }
  }
}
