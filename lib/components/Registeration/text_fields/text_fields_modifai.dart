// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

enum ModifAiBotTextFieldType { select, prompt }

class ModifAiTextField extends StatefulWidget {
  TextEditingController textEditingController;
  String? labelText;
  Widget? suffixIcon;
  ModifAiBotTextFieldType? textFieldType;
  ModifAiTextField.customized({
    super.key,
    required this.textEditingController,
    required this.labelText,
    this.suffixIcon,
  });
  ModifAiTextField.type(
      {super.key,
      required this.textEditingController,
      required this.textFieldType});

  @override
  State<ModifAiTextField> createState() => _ModifAiTextFieldState();
}

class _ModifAiTextFieldState extends State<ModifAiTextField> {
  @override
  Widget build(BuildContext context) {
    switch (widget.textFieldType) {
      case ModifAiBotTextFieldType.prompt:
      default:
        return TextFormField(
          cursorColor: const Color(0xff0f969c),
          style: const TextStyle(color: Color(0xff0f969c)),
          controller: widget.textEditingController,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Color(0xff0f969c)),
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 32, 82, 107))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0f969c))),
            focusColor: const Color(0xff0f969c),
            labelText: widget.labelText,
          ),
        );
    }
  }
}
