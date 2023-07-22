import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

class ModifAiWaitAnimation extends StatefulWidget {
  const ModifAiWaitAnimation({super.key});

  @override
  State<ModifAiWaitAnimation> createState() => _ModifAiWaitAnimationState();
}

class _ModifAiWaitAnimationState extends State<ModifAiWaitAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AnimateGradient(
          duration: const Duration(milliseconds: 1000),
          primaryColors: const [
            Color.fromARGB(255, 239, 229, 229),
            Colors.blueGrey,
            Colors.white,
          ],
          secondaryColors: const [
            Colors.white,
            Colors.black,
            Colors.blueGrey,
          ],
          child: Container(),
        ),
      ),
    );
  }
}
