import 'package:infection_in_population_simulator/simulation/individual/individual_state/individual_state.dart';
import 'package:infection_in_population_simulator/simulation/vector.dart';

class Individual {
  double x;
  double y;
  Vector vector;
  IndividualState state;

  Individual({
    required this.x,
    required this.y,
    required this.vector,
    required this.state,
  });

  //TODO factory random and border

  @override
  int get hashCode => Object.hash(x, y, vector, state);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Individual) return false;
    return other.x == x &&
        other.y == y &&
        other.vector == vector &&
        other.state == state;
  }
}
