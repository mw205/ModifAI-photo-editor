import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifAiBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ModifAiBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xff6da5c0),
      ),
      child: IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap!();
          } else {
            Get.back();
          }
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color.fromARGB(255, 226, 226, 226),
        ),
      ),
    );
  }
}
