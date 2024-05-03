import 'dart:collection';

import 'package:bulls_and_cows_flutter/utils/duplicate_exception.dart';
import 'package:bulls_and_cows_flutter/utils/invalid_input_exception.dart';
import 'package:flutter/material.dart';

import '../models/attempt.dart';
import '../models/game.dart';

class GameViewModel extends ChangeNotifier {
  final _game = Game();
  final _pickedNumbers = <int, int>{1: 1, 2: 2, 3: 3, 4: 4};
  final List<Attempt> _attempts = [];
  var _isGameOver = false;
  String? _message;

  get pickedNumbers => UnmodifiableMapView(_pickedNumbers);

  List<Attempt> get attempts => List.unmodifiable(_attempts);

  bool get isGameOver => _isGameOver;

  String? get message => _message;

  void numberPicked(int position, int value) {
    if (value >= 0 && value <= 9 && position >= 1 && position <= 4) {
      _pickedNumbers[position] = value;
      notifyListeners();
    }
  }

  void onAttempt() {
    try {
      final newAttempt =
          _game.evaluateUserInput(_pickedNumbers.values.toList());
      _attempts.add(newAttempt);
      _isGameOver = _game.isGameOver(newAttempt);
      if (_isGameOver) {
        _message = "You win!!!";
      }
    } on DuplicateException catch (e) {
      _message = e.message;
    } on InvalidInputException catch (e) {
      _message = e.message;
    }
    notifyListeners();
  }

  void restart() {
    _message = null;
    _isGameOver = false;
    _attempts.clear();
    _pickedNumbers[1] = 1;
    _pickedNumbers[2] = 2;
    _pickedNumbers[3] = 3;
    _pickedNumbers[4] = 4;
    _game.restart();
    notifyListeners();
  }

  void messageHandled() {
    _message = null;
  }
}
