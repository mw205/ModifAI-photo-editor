import 'package:flutter/material.dart';

class ClearTextButton extends StatefulWidget {
  final TextEditingController textEditingController;
  const ClearTextButton({super.key, required this.textEditingController});

  @override
  State<ClearTextButton> createState() => _ClearTextButtonState();
}

class _ClearTextButtonState extends State<ClearTextButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: height * 0.055,
      height: height * 0.055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.05),
        color: const Color.fromARGB(104, 15, 149, 156),
      ),
      child: IconButton(
        color: const Color.fromARGB(255, 58, 201, 208),
        onPressed: () {
          widget.textEditingController.clear();
        },
        icon: Icon(
          Icons.cleaning_services_rounded,
          size: height * 0.03,
        ),
      ),
    );
  }
}
