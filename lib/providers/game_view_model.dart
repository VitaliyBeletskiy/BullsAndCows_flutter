import 'dart:collection';

import 'package:bulls_and_cows_flutter/repos/flutter_game_repository.dart';
import 'package:bulls_and_cows_flutter/repos/game_repository.dart';
import 'package:flutter/material.dart';

import '../models/guess.dart';

class GameViewModel extends ChangeNotifier {
  final GameRepository _gameRepo = FlutterGameRepository();

  final _pickedNumbers = <int, int>{1: 1, 2: 2, 3: 3, 4: 4};
  final List<Guess> _guesses = [];
  var _isGameOver = false;
  String? _message;

  get pickedNumbers => UnmodifiableMapView(_pickedNumbers);

  List<Guess> get guesses => List.unmodifiable(_guesses);

  bool get isGameOver => _isGameOver;

  String? get message => _message;

  GameViewModel() {
    _gameRepo.guessList.listen((guessList) {
      _guesses.clear();
      _guesses.addAll(guessList);
      notifyListeners();
    });
  }

  void onNumberPicked(int position, int value) {
    if (value >= 0 && value <= 9 && position >= 1 && position <= 4) {
      _pickedNumbers[position] = value;
      notifyListeners();
    }
  }

  void onNewGuess() {
    try {
      _validateUserInput();
    } catch (e) {
      return;
    }
    _isGameOver = _gameRepo.evaluateUserInput(_pickedNumbers.values.toList());
    notifyListeners();
  }

  void restart() {
    _message = null;
    _isGameOver = false;
    _guesses.clear();
    _pickedNumbers.clear();
    _pickedNumbers.addAll({1: 1, 2: 2, 3: 3, 4: 4});
    _gameRepo.restart();
    notifyListeners();
  }

  void messageHandled() {
    _message = null;
  }

  void _validateUserInput() {
    if (_pickedNumbers.values.length != 4) {
      _message = "Enter four numbers";
      notifyListeners();
      throw Exception();
    }
    if (_pickedNumbers.values.length != _pickedNumbers.values.toSet().length) {
      _message = "Numbers must not repeat.";
      notifyListeners();
      throw Exception();
    }
  }
}
