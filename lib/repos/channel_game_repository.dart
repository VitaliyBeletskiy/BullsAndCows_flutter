import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/guess.dart';
import 'game_repository.dart';

const _eventChannelTag = 'event_channel';
const _methodChannelTag = 'method_channel';
const _evaluateUserInputTag = 'evaluateUserInput';
const _restartTag = 'restart';

class ChannelGameRepository extends GameRepository {
  final _gameStream =
      const EventChannel(_eventChannelTag).receiveBroadcastStream();
  final _gameMethodChannel = const MethodChannel(_methodChannelTag);

  ChannelGameRepository() {
    guessList = _gameStream.map((data) {
      try {
        final json = jsonDecode(data);
        final guesses = (json as List).map((e) => Guess.fromJson(e)).toList();
        return guesses;
      } catch (_) {
        rethrow;
      }
    });
  }

  @override
  Future<bool> evaluateUserInput(List<int> userInput) async {
      final bool result = await _gameMethodChannel.invokeMethod(
        _evaluateUserInputTag,
        userInput,
      );
      return result;
  }

  @override
  void restart() {
    _gameMethodChannel.invokeMethod(_restartTag);
  }
}
