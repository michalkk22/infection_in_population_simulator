import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/constants/simulation_area.dart';
import 'package:infection_in_population_simulator/simulation/simulation.dart'
    as my;

class SimulationView extends StatefulWidget {
  final my.Simulation simulation;

  const SimulationView({required this.simulation, super.key});

  @override
  State<SimulationView> createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  @override
  void initState() {
    super.initState();
    widget.simulation.start(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.simulation.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderPadding = 4 * SimulationArea.individualDotSize;

    return Container(
      height: SimulationArea.height + borderPadding,
      width: SimulationArea.width + borderPadding - 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: SimulationArea.borderWidth,
        ),
      ),
      padding: const EdgeInsets.all(SimulationArea.individualDotSize),
      child: CustomPaint(
        size: const Size(SimulationArea.width, SimulationArea.height),
        painter: _SimulationPainter(points: widget.simulation.points),
      ),
    );
  }
}

class _SimulationPainter extends CustomPainter {
  final Iterable<Point<double>> points;

  _SimulationPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.blue;

    for (var point in points) {
      canvas.drawCircle(
        Offset(point.x, point.y),
        SimulationArea.individualDotSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
