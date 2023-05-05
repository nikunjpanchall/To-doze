import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class CircularAnimation extends StatelessWidget {
  const CircularAnimation({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: 80,
      numberOfParticles: 80,
      speedOfParticles: 1,
      height: screenHeight,
      width: screenWidth,
      onTapAnimation: true,
      particleColor: Colors.grey.shade900.withAlpha(900),
      awayAnimationDuration: const Duration(milliseconds: 600),
      maxParticleSize: 8,
      isRandSize: true,
      isRandomColor: true,
      randColorList: [
        Colors.grey.shade600.withAlpha(210),
        Colors.grey.shade800.withAlpha(210),
        Colors.grey.shade900.withAlpha(210),
        Colors.grey.shade900.withAlpha(210)
      ],
      connectDots: true, //not recommended
    );
  }
}
