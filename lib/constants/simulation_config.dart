import 'package:flutter/material.dart';

abstract class SimulationConfig {
  static const double height = 500;
  static const double width = 500;
  static const double borderWidth = 4;
  static const double individualDotSize = 4;
  static const int populationSize = 50;
  static const int infected = 10;
  static const double populationIncreasePerSecond = 5;
  static const Duration tickDuration = Duration(milliseconds: 4);
  static const double secondsToInfect = 3;
  static const double borderVectorPenalty = -0.4;
  static const double nextVectorDeviation = 0.02;
  static const double oneMeter = 50;

  static const Color stateSymptomsColor = Colors.red;
  static const Color stateInfectedColor = Colors.orange;
  static const Color stateSusceptibleColor = Colors.green;
  static const Color stateImmuneColor = Colors.blue;
}
