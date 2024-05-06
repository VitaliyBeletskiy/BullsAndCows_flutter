import 'package:bulls_and_cows_flutter/providers/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../widgets/guess_list_item.dart';
import '../widgets/number_picker_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  Future<int> _pickNumber(BuildContext context) async {
    final pickedNumber = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return const NumberPickerDialog();
        });
    return pickedNumber ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          // region here we listen for messages
          if (gameViewModel.message != null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(gameViewModel.message ?? ""),
                    duration: const Duration(seconds: 3),
                  ),
                );
                gameViewModel.messageHandled();
              },
            );
          }
          // endregion
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: gameViewModel.isGameOver ? const Text("You win!") : const Text("Bulls & Cows"),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => gameViewModel.restart(),
                      child: const Icon(
                        Icons.restart_alt_sharp,
                        size: 32.0,
                      ),
                    )),
              ],
            ),
            body: Ink(
              color: secondaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: gameViewModel.guesses.length,
                      itemBuilder: (ctx, index) {
                        return GuessListItem(
                          guess: gameViewModel.guesses[index],
                        );
                      },
                    ),
                  ),
                  if (!gameViewModel.isGameOver) Ink(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _pickNumber(context).then((value) =>
                                  gameViewModel.numberPicked(1, value));
                            },
                            child: SvgPicture.asset(
                                'assets/images/${gameViewModel.pickedNumbers[1]}.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              _pickNumber(context).then((value) =>
                                  gameViewModel.numberPicked(2, value));
                            },
                            child: SvgPicture.asset(
                                'assets/images/${gameViewModel.pickedNumbers[2]}.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              _pickNumber(context).then((value) =>
                                  gameViewModel.numberPicked(3, value));
                            },
                            child: SvgPicture.asset(
                                'assets/images/${gameViewModel.pickedNumbers[3]}.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              _pickNumber(context).then((value) =>
                                  gameViewModel.numberPicked(4, value));
                            },
                            child: SvgPicture.asset(
                                'assets/images/${gameViewModel.pickedNumbers[4]}.svg'),
                          ),
                          ElevatedButton(
                            onPressed: () => gameViewModel.onNewGuess(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'TRY',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
