import 'dart:async';

import 'package:infection_in_population_simulator/simulation/population.dart';

class Simulation {
  final Population population;
  final Duration tickDuration;
  late final Timer _timer;
}
