import 'dart:async';
import 'dart:math';

import '../models/guess.dart';

class GameController {
  final _random = Random();
  final _secretNumber = [1, 2, 3, 4];
  int _guessNumber = 0;
  final _guessList = <Guess>[];
  final _guessStream = StreamController<List<Guess>>();
  Stream<List<Guess>> get guesses => _guessStream.stream;

  GameController() {
    _generateSecretNumber();
  }

  bool evaluateUserInput(List<int> userInput) {
    if (userInput.length != 4 || userInput.length != userInput.toSet().length) {
      throw Exception();
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
    _guessNumber++;

    _guessList.add(Guess(number: _guessNumber, values: userInput, results: result));
    _guessStream.add(_guessList);

    return result.every((element) => element == Result.bull);
  }

  void restart() {
    _generateSecretNumber();
    _guessNumber = 0;
    _guessList.clear();
    _guessStream.add(_guessList);
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
