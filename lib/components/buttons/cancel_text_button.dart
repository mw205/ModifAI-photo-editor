import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Color(0xff0f969c),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
