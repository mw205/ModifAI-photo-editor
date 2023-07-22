import 'package:flutter/material.dart';

class ModifAiDrawerButton extends StatelessWidget {
  const ModifAiDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, top: 8),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(0xff6da5c0),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
