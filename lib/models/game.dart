import 'dart:math';

import 'package:bulls_and_cows_flutter/utils/invalid_input_exception.dart';

import '../utils/duplicate_exception.dart';
import 'attempt.dart';

class Game {
  final List<int> _secretNumber = [1, 2, 3, 4];
  final _random = Random();
  int _attemptNumber = 0;

  Game() {
    _generateSecretNumber();
  }

  Attempt evaluateUserInput(List<int> userInput) {
    if (userInput.length != 4) {
      throw InvalidInputException("User Input must contain 4 integers.");
    }
    if (userInput.length != userInput.toSet().length) {
      throw DuplicateException("User Input must not contain duplicates.");
    }

    List<Result> result = [];
    for (int i = 0; i < _secretNumber.length; i++) {
      if (userInput[i] == _secretNumber[i]) {
        // if both value and position match
        result.add(Result.bull);
      } else if (_secretNumber.contains(userInput[i])) {
        // if secretNumber contains this value in any position
        result.add(Result.cow);
      } else {
        // secretNumber doesn't contain this value
        result.add(Result.nothing);
      }
    }
    result.sort((a, b) => b.index.compareTo(a.index));
    _attemptNumber++;
    return Attempt(number: _attemptNumber, values: userInput, results: result);
  }

  bool isGameOver(Attempt attempt) {
    // check if attempt.results contains only Result.bull values
    return attempt.results.every((element) => element == Result.bull);
  }

  void restart() {
    _generateSecretNumber();
    _attemptNumber = 0;
  }

  void _generateSecretNumber() {
    _secretNumber.clear();

    while (_secretNumber.length < 4) {
      int newNumber = _random.nextInt(10);
      if (!_secretNumber.contains(newNumber)) {
        _secretNumber.add(newNumber);
      }
    }
  }
}
