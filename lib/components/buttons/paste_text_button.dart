import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasteButton extends StatelessWidget {
  final TextEditingController textEditingController;

  const PasteButton({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'Paste',
        style: TextStyle(
          color: Color(0xff0f969c),
        ),
      ),
      onPressed: () {
        FlutterClipboard.paste().then((value) {
          if (value == "") {
            Get.snackbar(
              "Alert",
              "Your clipboard is empty",
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          textEditingController.text = value;
        });
      },
    );
  }
}
