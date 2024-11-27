import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/simulation/simulation.dart'
    as my;
import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual_list.dart';
import 'package:infection_in_population_simulator/simulation/population.dart';
import 'package:infection_in_population_simulator/views/simulation_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSimulationStarted = false;
  late final my.Simulation _simulation;

  @override
  void initState() {
    super.initState();
    final population = Population(IndividualList(
        collection: List.generate(50, (_) => Individual.random())));

    _simulation = my.Simulation(population: population);
  }

  void _startSimulation() {
    setState(() {
      _isSimulationStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Simulation'),
      ),
      body: Center(
        child: _isSimulationStarted
            ? SimulationView(
                simulation: _simulation,
              )
            : TextButton(
                onPressed: _startSimulation,
                child: const Text('Start Simulation'),
              ),
      ),
    );
  }
}
