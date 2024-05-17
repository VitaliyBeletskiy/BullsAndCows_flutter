import 'dart:async';

import 'package:bulls_and_cows_flutter/game_api.dart';
import 'package:bulls_and_cows_flutter/models/guess.dart';
import 'package:bulls_and_cows_flutter/repos/game_repository.dart';

import '../utils/mappers.dart';

class PigeonGameRepository extends GameRepository implements GameFlutterApi {

  final _nativeApi = GameNativeApi();
  final _streamController = StreamController<List<Guess>>();

  PigeonGameRepository() {
    GameFlutterApi.setUp(this);
    guessList = _streamController.stream;
  }

  @override
  Future<bool> evaluateUserInput(List<int> userInput) {
    return _nativeApi.evaluateUserInput(userInput);
  }

  @override
  void restart() {
    _nativeApi.restart();
  }

  @override
  void onNewGuessList(List<GuessMessage?> guessMessages) async {
    final guessList = GuessMapper.map(guessMessages);
    _streamController.sink.add(guessList);
  }
}
