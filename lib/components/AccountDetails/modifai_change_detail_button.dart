import 'package:flutter/material.dart';

class ChangeDetailsButton extends StatelessWidget {
  final void Function()? onTap;
  const ChangeDetailsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width * 0.12,
        height: height * 0.036,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff6da5c0),
        ),
        child: const Icon(
          Icons.edit,
          color: Color.fromARGB(255, 226, 226, 226),
        ),
      ),
    );
  }
}
