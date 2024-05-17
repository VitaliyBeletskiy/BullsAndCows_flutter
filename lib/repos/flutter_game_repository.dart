// import 'package:bulls_and_cows_flutter/game/bulls_and_cows_game.dart';
//
// import 'game_repository.dart';
//
// class FlutterGameRepository extends GameRepository {
//   final _game = BullsAndCowsGame();
//
//   FlutterGameRepository() {
//     guessList = _game.guesses;
//   }
//
//   @override
//   Future<bool> evaluateUserInput(List<int> userInput) {
//     return Future(() => _game.evaluateUserInput(userInput));
//   }
//
//   @override
//   void restart() => _game.restart();
// }
