import 'package:infection_in_population_simulator/simulation/individual/individual_state/individual_state.dart';

class IndividualStateImmune implements IndividualState {
  @override
  handle() {}

  @override
  bool operator ==(Object other) {
    return (other is IndividualStateImmune);
  }
}
