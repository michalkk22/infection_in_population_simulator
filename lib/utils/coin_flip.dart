import 'dart:math';

abstract class CoinFlip {
  bool flip() {
    return Random().nextBool();
  }
}
