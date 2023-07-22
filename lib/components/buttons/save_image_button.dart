import 'package:flutter/material.dart';

class SaveImageButton extends StatelessWidget {
  final Function onSaveImage;
  const SaveImageButton({super.key, required this.onSaveImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xff6da5c0),
      ),
      child: IconButton(
        onPressed: () {
          onSaveImage();
        },
        icon: const Icon(
          Icons.save_alt_outlined,
          color: Color.fromARGB(255, 226, 226, 226),
          size: 30,
        ),
      ),
    );
  }
}
