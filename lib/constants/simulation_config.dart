import 'package:flutter/material.dart';

abstract class SimulationConfig {
  static const double borderWidth = 4;
  static const double individualDotSize = 4;
  static const double height = 500;
  static const double width = 500;
  static const int populationSize = 50;
  static const int infected = 10;
  static const int immune = 0;
  static const double borderVectorPenalty = -0.4;
  static const double nextVectorDirectionDeviation = 0.1;
  static const double nextVectorSpeedDeviation = 0.05;
  static const double oneMeter = 50;
  static const double maxSpeed = 1;
  static const double infectionRange = 2 * oneMeter;
  static const double populationIncreasePerSecond = 15;
  static const Duration tickDuration = Duration(milliseconds: 40);
  static const double secondsToInfect = 3;
  static const double minRecoverySeconds = 20;
  static const double maxRecoverySeconds = 30;

  static const Color stateSymptomsColor = Colors.red;
  static const Color stateInfectedColor = Colors.orange;
  static const Color stateSusceptibleColor = Colors.green;
  static const Color stateImmuneColor = Colors.blue;
}
