import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 10, 45, 52),
      title: const Text(
        'Confirmation',
        style: TextStyle(fontSize: 25, color: Color(0xff0f969c)),
      ),
      content: const Text(
        "Are you sure to make this operation ?",
        style: TextStyle(
            fontSize: 17,
            color: Color(0xff0f969c),
            fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 14, color: Color(0xff0f969c)),
          ),
        ),
      ],
    );
  }
}
