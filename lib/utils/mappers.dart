import 'package:bulls_and_cows_flutter/models/guess.dart';
import 'package:bulls_and_cows_flutter/models/result.dart';

import '../game_api.dart';

class GuessMapper {
  GuessMapper._();

  static List<Guess> map(List<GuessMessage?> guessMessages) {
    return guessMessages.map((gm) {
      gm!;
      final guessNumber = gm.number;
      final guessValues = gm.values.map((e) => e!).toList();
      final guessResults =
          gm.resultOrdinals.map((e) => Result.values[e!]).toList();

      return Guess(
        number: guessNumber,
        values: guessValues,
        results: guessResults,
      );
    }).toList();
  }
}
