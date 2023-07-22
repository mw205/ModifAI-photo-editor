
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModifAiText extends StatelessWidget {
  final String text;
  final double fontSize;

  const ModifAiText({super.key, required this.text, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(-2, -0.5),
            blurRadius: 1,
            color: Color(0xff6da5c0),
          ),
        ],
        color: const Color.fromARGB(255, 255, 255, 255),
        fontSize: fontSize,
      ),
    ).animate().fade(
          duration: const Duration(milliseconds: 1000),
        );
  }
}
