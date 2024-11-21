import 'dart:math';

abstract class CoinFlip {
  static bool flip() {
    return Random().nextBool();
  }
}
