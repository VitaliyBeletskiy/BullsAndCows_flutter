import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/game_api.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/app/src/main/kotlin/com/beletskiy/bullsandcows/flutter/GameApi.kt',
  kotlinOptions: KotlinOptions(),
  dartPackageName: 'bulls_and_cows_flutter',
))

class GuessMessage {
  GuessMessage(
    this.number,
    this.values,
    this.resultOrdinals,
  );

  final int number;
  final List<int?> values;
  final List<int?> resultOrdinals;
}

@HostApi()
abstract class GameNativeApi {
  bool evaluateUserInput(List<int> userInput);

  void restart();
}

@FlutterApi()
abstract class GameFlutterApi {
  void onNewGuessList(List<GuessMessage> guessMessages);
}
