import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/views/simulation_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSimulationStarted = false;

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
            ? SimulationView()
            : TextButton(
                onPressed: _startSimulation,
                child: const Text('Start Simulation'),
              ),
      ),
    );
  }
}
