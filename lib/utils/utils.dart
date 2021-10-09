import 'package:flutter/material.dart';

class Utils {
  static List<Color> getColorPair(int index) {
    if (index == 0) {
      return const [
        Color.fromRGBO(249, 240, 202, 1),
        Color.fromRGBO(234, 207, 199, 1)
      ];
    }
    if (index == 1) {
      return const [
        Color.fromRGBO(190, 215, 198, 1),
        Color.fromRGBO(223, 209, 193, 1)
      ];
    }
    return const [
      Color.fromRGBO(178, 188, 219, 1),
      Color.fromRGBO(224, 208, 192, 1)
    ];
  }

  static int getRealIndex(int position, int base, int? length) {
    final int offset = position - base;
    return remainder(offset, length);
  }

  /// Returns the remainder of the modulo operation [input] % [source], and adjust it for
  /// negative values.
  static int remainder(int input, int? source) {
    if (source == 0) return 0;
    final int result = input % source!;
    return result < 0 ? source + result : result;
  }
}
