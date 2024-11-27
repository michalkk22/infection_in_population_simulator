import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_collection.dart';

class Population {
  final IndividualCollection _individuals;
  final double _pupulationIncreasePerTick =
      SimulationConfig.populationIncreasePerSecond *
          100 /
          SimulationConfig.tickDuration.inMilliseconds;
  double _counter = 0;

  Population(this._individuals);

  void update() {
    _individuals.update();

    _counter++;
    while (_counter > _pupulationIncreasePerTick) {
      _individuals.add(Individual.randomBorder());
      _counter -= _pupulationIncreasePerTick;
    }
  }

  Iterable<Individual> get individuals => _individuals.individuals;
}
