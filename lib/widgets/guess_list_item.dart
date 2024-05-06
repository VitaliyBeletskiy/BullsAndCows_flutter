import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/guess.dart';
import '../utils/app_colors.dart';

class GuessListItem extends StatelessWidget {
  const GuessListItem({super.key, required this.guess});

  final Guess guess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${guess.number}",
            style: const TextStyle(color: textColor, fontSize: 18.0),
          ),
          Row(
            children: [
              SizedSvgImage(size: 40, imageName: guess.values[0].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: guess.values[1].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: guess.values[2].toString()),
              const SizedBox(width: 8),
              SizedSvgImage(size: 40, imageName: guess.values[3].toString()),
            ],
          ),
          Row(
            children: <Widget>[
              SizedSvgImage(size: 20, imageName: guess.results[0].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: guess.results[1].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: guess.results[2].name),
              const SizedBox(width: 8),
              SizedSvgImage(size: 20, imageName: guess.results[3].name),
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
