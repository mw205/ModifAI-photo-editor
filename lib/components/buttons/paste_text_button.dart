import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/preview_image.dart';
import 'package:modifai/services/media.dart';

class PasteButton extends StatelessWidget {
  final TextEditingController textEditingController;

  const PasteButton({super.key, required this.textEditingController});
  _onSearch(String? imageUrl) async {
    DialogUtils.modifAiProgressindicator();
    bool isImage = await Media.isImageURL(imageUrl!);
    if (isImage == true) {
      Future<Uint8List?> imageData = Media.loadImageData(imageUrl);
      Get.to(
            () => ImageViewerScreen.data(
          data: imageData,
        ),
      );

    }
  }

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
            Get.back();
            Get.snackbar(
              "Alert",
              "Your clipboard is empty",
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          textEditingController.text = value;
          _onSearch(textEditingController.text);
        });
      },
    );
  }
}
