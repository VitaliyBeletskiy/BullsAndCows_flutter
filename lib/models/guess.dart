import 'result.dart';

class Guess {
  final int number;
  final List<int> values;
  final List<Result> results;

  Guess({
    required this.number,
    required this.values,
    required this.results,
  });

  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      number: json['number'],
      values: json['userInput'].cast<int>(),
      results: List<Result>.from(json["results"].map((x) => Result.fromString(x))),
    );
  }

  @override
  String toString() {
    return 'Guess(number:$number, values:$values, results:$results)';
  }
}
