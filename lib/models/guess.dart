class Guess {
  final int number;
  final List<int> values;
  final List<Result> results;

  Guess({
    required this.number,
    required this.values,
    required this.results,
  });
}

enum Result { nothing, cow, bull }
