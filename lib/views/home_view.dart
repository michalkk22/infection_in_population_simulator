import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/views/simulation_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Simulation'),
      ),
      body: Center(
        child: SimulationView(),
        // child: Builder(builder: builder),//TODO builder
      ),
    );
  }
}
