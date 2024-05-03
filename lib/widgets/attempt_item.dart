import 'package:bulls_and_cows_flutter/models/attempt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

class AttemptItem extends StatelessWidget {
  const AttemptItem({super.key, required this.attempt});

  final Attempt attempt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${attempt.number}",
            style: const TextStyle(color: textColor, fontSize: 18.0),
          ),
          Row(
            children: [
              SizedSvgImage(size: 40, imageName: attempt.values[0].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: attempt.values[1].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: attempt.values[2].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: attempt.values[3].toString()),
            ],
          ),
          Row(
            children: <Widget>[
              SizedSvgImage(size: 20, imageName: attempt.results[0].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: attempt.results[1].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: attempt.results[2].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: attempt.results[3].name),
            ],
          ),
        ],
      ),
    );
  }
}

class SizedSvgImage extends StatelessWidget {
  const SizedSvgImage({
    super.key,
    required this.size,
    required this.imageName,
  });

  final double size;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset('assets/images/$imageName.svg'),
    );
  }
}
