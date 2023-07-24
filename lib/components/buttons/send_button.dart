import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/output_image.dart';
import 'package:modifai/services/media.dart';

class SendButton extends StatefulWidget {
  final String? photoId;
  final String? promptText;
  final String? selectText;
  const SendButton({
    super.key,
    required this.photoId,
    this.promptText,
    this.selectText,
  });

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    String? mediaURL;
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
        icon: const Icon(
          Icons.send_rounded,
          size: 23,
        ),
        onPressed: () async {
          if (widget.promptText == "" || widget.selectText == "") {
            Get.snackbar(
              "Alert",
              "you can't keep any of these text fields empty, please fill them ",
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Get.snackbar(
              "Alert",
              "Your photo is being edited now and will take a while, please wait ",
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            DialogUtils.modifAiProgressindicator();
            mediaURL = await Media.modifAIBot(
              prompt: widget.promptText!,
              mask: widget.selectText!,
              photoId: widget.photoId!,
            );
            if (mediaURL != null) {
              Get.back();
              Get.to(() => ShowOutputImage(mediaUrl: mediaURL!));
            } else {
              Get.back();
              Get.snackbar(
                "Alert",
                "There is an error in our servers 😔!! try again later ",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
        },
      ),
    );
  }
}
