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
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (45 / width),
      height: height * (45 / height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(104, 15, 149, 156),
      ),
      child: IconButton(
        color: const Color.fromARGB(255, 58, 201, 208),
        onPressed: () {
          widget.textEditingController.clear();
        },
        icon: const Icon(
          Icons.cleaning_services_rounded,
          size: 23,
        ),
      ),
    );
  }
}
