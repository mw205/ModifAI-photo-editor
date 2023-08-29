import 'package:flutter/material.dart';
import 'package:modifai/components/buttons/clear_text_button.dart';

enum ModifAiBotTextFieldType { select, prompt, search }

class ModifAiTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final ModifAiBotTextFieldType? textFieldType;
  final int? maxLines;
  final int? maxLength;

  const ModifAiTextField.customized(
      {Key? key,
      required this.textEditingController,
      required this.labelText,
      this.hintText,
      this.suffixIcon,
      required this.maxLines,
      this.maxLength})
      : textFieldType = null,
        super(key: key);

  const ModifAiTextField.type(
      {super.key,
      required this.textEditingController,
      required this.textFieldType,
      this.suffixIcon})
      : labelText = "",
        hintText = "",
        maxLength = null,
        maxLines = 1;

  @override
  State<ModifAiTextField> createState() => _ModifAiTextFieldState();
}

class _ModifAiTextFieldState extends State<ModifAiTextField> {
  @override
  Widget build(BuildContext context) {
    switch (widget.textFieldType) {
      case ModifAiBotTextFieldType.select:
        return ModifAiTextField.customized(
          labelText: 'Select what you want to change',
          hintText: "Tell the bot what is the thing you want to change",
          maxLines: 1,
          textEditingController: widget.textEditingController,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClearTextButton(
                textEditingController: widget.textEditingController),
          ),
        );

      case ModifAiBotTextFieldType.prompt:
        return ModifAiTextField.customized(
          textEditingController: widget.textEditingController,
          labelText: "Enter a prompt",
          hintText:
              "Describe to the bot what you want to change in your selection",
          maxLength: 500,
          maxLines: 3,
          suffixIcon: widget.suffixIcon,
        );
      case ModifAiBotTextFieldType.search:
        return ModifAiTextField.customized(
            textEditingController: widget.textEditingController,
            labelText: "Press and Paste URL of the Image",
            maxLines: 1);
      default:
        return TextFormField(
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: const Color(0xff0f969c),
          style: const TextStyle(color: Color(0xff0f969c)),
          controller: widget.textEditingController,
          decoration: InputDecoration(
            counterStyle: const TextStyle(
              color: Color(0xff0f969c),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
            labelStyle: const TextStyle(color: Color(0xff0f969c)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 32, 82, 107)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0f969c)),
            ),
            focusColor: const Color(0xff0f969c),
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(123, 15, 149, 156), fontSize: 15),
            suffixIcon: widget.suffixIcon,
          ),
        );
    }
  }
}
