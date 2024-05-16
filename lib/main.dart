import 'package:bulls_and_cows_flutter/screens/game_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BullsAndCowsApp());
}

class BullsAndCowsApp extends StatelessWidget {
  const BullsAndCowsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bulls & Cows',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}
