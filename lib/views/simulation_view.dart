import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/constants/simulation_area.dart';

class SimulationView extends StatefulWidget {
  const SimulationView({super.key});

  @override
  State<SimulationView> createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SimulationArea.height,
      width: SimulationArea.width,
      child: Text('dupa'),
    );
  }
}
