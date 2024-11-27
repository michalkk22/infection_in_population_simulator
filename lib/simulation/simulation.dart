import 'dart:async';
import 'dart:math';

import 'package:infection_in_population_simulator/simulation/population.dart';

class Simulation {
  final Population population;
  final Duration tickDuration;
  late final Timer _timer;

  Simulation({
    required this.population,
    this.tickDuration = const Duration(milliseconds: 25),
  });

  void start(void Function() onTick) {
    _timer = Timer.periodic(tickDuration, (_) {
      population.update();
      onTick();
    });
  }

  void stop() {
    _timer.cancel();
  }

  Iterable<Point<double>> get points => population.points;
}
