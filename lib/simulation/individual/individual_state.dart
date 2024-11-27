import 'package:flutter/material.dart';
import 'package:infection_in_population_simulator/constants/simulation_config.dart';

abstract class IndividualState {
  Color get color;

  handle();
}

abstract class IndividualStateHealthy extends IndividualState {}

class IndividualStateImmune extends IndividualStateHealthy {
  @override
  handle() {}

  @override
  Color get color => SimulationConfig.stateImmuneColor;
}

class IndividualStateSusceptible extends IndividualStateHealthy {
  @override
  handle() {}

  @override
  Color get color => SimulationConfig.stateSusceptibleColor;
}

class IndividualStateInfected extends IndividualState {
  @override
  handle() {}

  @override
  Color get color => SimulationConfig.stateInfectedColor;
}

class IndividualStateSymptoms extends IndividualStateInfected {
  @override
  Color get color => SimulationConfig.stateSymptomsColor;
}
