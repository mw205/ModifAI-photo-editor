import 'package:flutter/material.dart';

class ModifAiCheck extends StatelessWidget {
  const ModifAiCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 18.0, top: 7),
          child: Icon(
            size: 40,
            Icons.check,
            color: Color(0xff6da5c0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.0, top: 7, left: 0.25),
          child: Icon(
            size: 42,
            Icons.check,
            color: Color.fromARGB(255, 226, 226, 226),
          ),
        ),
      ],
    );
  }
}
