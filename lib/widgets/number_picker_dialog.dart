import 'package:bulls_and_cows_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NumberPickerDialog extends StatelessWidget {
  const NumberPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    return const Dialog(
        backgroundColor: primaryColor,
        insetPadding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pick a number',
                style: TextStyle(
                    color: textColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NumberPickerItem(padding: padding, value: 1),
                      _NumberPickerItem(padding: padding, value: 2),
                      _NumberPickerItem(padding: padding, value: 3),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NumberPickerItem(padding: padding, value: 4),
                      _NumberPickerItem(padding: padding, value: 5),
                      _NumberPickerItem(padding: padding, value: 6),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NumberPickerItem(padding: padding, value: 7),
                      _NumberPickerItem(padding: padding, value: 8),
                      _NumberPickerItem(padding: padding, value: 9),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NumberPickerItem(padding: padding, value: 0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class _NumberPickerItem extends StatelessWidget {
  const _NumberPickerItem({
    super.key,
    required this.padding,
    required this.value,
  });

  final double padding;
  final int value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, value),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset('assets/images/$value.svg'),
      ),
    );
  }
}

class NumberPickerDialogOld extends StatelessWidget {
  const NumberPickerDialogOld({super.key});

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    return const SimpleDialog(
      title: Text('Pick a number'),
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                _NumberPickerItem(padding: padding, value: 1),
                _NumberPickerItem(padding: padding, value: 2),
                _NumberPickerItem(padding: padding, value: 3),
              ],
            ),
            Row(
              children: [
                _NumberPickerItem(padding: padding, value: 4),
                _NumberPickerItem(padding: padding, value: 5),
                _NumberPickerItem(padding: padding, value: 6),
              ],
            ),
            Row(
              children: [
                _NumberPickerItem(padding: padding, value: 7),
                _NumberPickerItem(padding: padding, value: 8),
                _NumberPickerItem(padding: padding, value: 9),
              ],
            ),
            Row(
              children: [
                _NumberPickerItem(padding: padding, value: 0),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
