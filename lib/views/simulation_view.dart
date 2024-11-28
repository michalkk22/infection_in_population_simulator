import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/constants/simulation_config.dart';
import 'package:infection_in_population_simulator/simulation/individual/individual.dart';
import 'package:infection_in_population_simulator/simulation/simulation.dart'
    as my;
import 'package:infection_in_population_simulator/simulation/simulation_memento.dart';
import 'package:infection_in_population_simulator/simulation/vector.dart';

class SimulationView extends StatefulWidget {
  final my.Simulation simulation;

  const SimulationView({required this.simulation, super.key});

  @override
  State<SimulationView> createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  SimulationMemento? _memento;

  @override
  void initState() {
    super.initState();
    widget.simulation.start(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.simulation.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderPadding = 4 * SimulationConfig.individualDotSize;

    return Column(
      children: [
        Container(
          height: SimulationConfig.height + borderPadding,
          width: SimulationConfig.width + borderPadding - 1,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: SimulationConfig.borderWidth,
            ),
          ),
          padding: const EdgeInsets.all(SimulationConfig.individualDotSize),
          child: CustomPaint(
            size: const Size(SimulationConfig.width, SimulationConfig.height),
            painter:
                _SimulationPainter(individuals: widget.simulation.individuals),
          ),
        ),
        TextButton(onPressed: createMemento, child: const Text('Save')),
        TextButton(onPressed: restoreMemento, child: const Text('Restore')),
      ],
    );
  }

  createMemento() {
    _memento = widget.simulation.createMemento();
  }

  restoreMemento() {
    if (_memento != null) {
      List<Individual> saved = [];
      for (var i in _memento!.population) {
        saved.add(Individual(
          position: Point(i.position.x, i.position.y),
          vector: Vector(x: i.vector.x, y: i.vector.y),
          state: i.state.thisState(),
        ));
      }
      var memento = SimulationMemento(population: saved);
      widget.simulation.restoreMemento(memento);
    }
  }
}

class _SimulationPainter extends CustomPainter {
  final Iterable<Individual> _individuals;

  _SimulationPainter({required Iterable<Individual> individuals})
      : _individuals = individuals;

  @override
  void paint(Canvas canvas, Size size) {
    for (var individual in _individuals) {
      final Paint paint = Paint()..color = individual.state.color;
      canvas.drawCircle(
        Offset(individual.position.x, individual.position.y),
        SimulationConfig.individualDotSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
