import '../models/guess.dart';

abstract class GameRepository {

  late Stream<List<Guess>> guessList;

  Future<bool> evaluateUserInput(List<int> userInput);

  void restart();
}
