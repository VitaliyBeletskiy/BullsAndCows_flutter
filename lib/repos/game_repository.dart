import '../models/guess.dart';

abstract class GameRepository {

  late Stream<List<Guess>> guessList;

  bool evaluateUserInput(List<int> userInput);

  void restart();
}
