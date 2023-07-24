import 'package:flutter/material.dart';

class ConfirmNameButton extends StatefulWidget {
  final String newName;
  final Function onPressed;
  const ConfirmNameButton(
      {super.key, required this.newName, required this.onPressed});

  @override
  State<ConfirmNameButton> createState() => _ConfirmNameButtonState();
}

class _ConfirmNameButtonState extends State<ConfirmNameButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xff6da5c0),
      ),
      child: IconButton(
        onPressed: () async {
          widget.onPressed();
        },
        icon: const Icon(
          Icons.check,
          color: Color.fromARGB(255, 226, 226, 226),
          size: 30,
        ),
      ),
    );
  }
}
