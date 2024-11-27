abstract class SimulationArea {
  static const double height = 500;
  static const double width = 500;
  static const double borderWidth = 4;
  static const double individualDotSize = 4;
  static const int populationSize = 50;
  static const double borderVectorPenalty = -0.4;
}

enum SimulationBorder {
  left,
  right,
  top,
  bottom,
}
