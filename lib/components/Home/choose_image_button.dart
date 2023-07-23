import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/home.dart';
import 'package:modifai/services/media.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../screens/gallery.dart';
import '../../screens/preview_image.dart';

enum ChooseImageButtonType { gallery, camera, file, search, customized }

class ChooseImageButton extends StatefulWidget {
  late final Text? buttonText;
  late final LottieBuilder? lottie;
  late final VoidCallback? onTap;
  late final ChooseImageButtonType? type;

  ChooseImageButton.customized({
    super.key,
    required this.buttonText,
    required this.lottie,
    required this.onTap,
  }) {
    type = null;
  }
  ChooseImageButton.type({super.key, required this.type}) {
    buttonText = null;
    lottie = null;
    onTap = null;
  }

  @override
  State<ChooseImageButton> createState() => _ChooseImageButtonState();
}

class _ChooseImageButtonState extends State<ChooseImageButton> {
  @override
  void initState() {
    super.initState();
  }

  _onSearch(String? imageUrl) async {
    if (imageUrl == "") {
      Get.back();
    } else {
      bool isImage = await Media.isImageURL(imageUrl!);
      if (isImage == true) {
        DialogUtils.modifAiProgressindicator();
        Future<Uint8List?> imageData = Media.loadImageData(imageUrl);
        Get.to(() => ImageViewerScreen.data(data: imageData));
      }
    }
  }

  // Future<void> _showSearchBar() async {
  //   final TextEditingController textEditingController = TextEditingController();
  //   final FocusNode focusNode = FocusNode();

  //   await showModalBottomSheet(
  //     constraints: BoxConstraints(),
  //     useSafeArea: true,
  //     backgroundColor: const Color.fromARGB(0, 255, 255, 255),
  //     isDismissible: true,
  //     context: context,

  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Color.fromARGB(255, 10, 45, 52),
  //         ),
  //         height: MediaQuery.of(context).size.height * 0.22,
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Center(
  //               child: Expanded(
  //                 child: TextField(
  //                   cursorColor: const Color(0xff0f969c),
  //                   style: const TextStyle(color: Color(0xff0f969c)),
  //                   decoration: InputDecoration(
  //                     suffixIcon: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(25),
  //                           color: const Color.fromARGB(104, 15, 149, 156),
  //                         ),
  //                         child: IconButton(
  //                             color: const Color(0xff0f969c),
  //                             icon: const Icon(Icons.search),
  //                             onPressed: () {
  //                               _onSearch(textEditingController.text);
  //                             }),
  //                       ),
  //                     ),
  //                     hintText: 'Paste URL of the Image',
  //                     hintStyle: const TextStyle(
  //                         color: Color.fromARGB(124, 15, 149, 156),
  //                         fontSize: 15),
  //                     labelStyle: const TextStyle(color: Color(0xff0f969c)),
  //                     enabledBorder: const OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: Color.fromARGB(255, 32, 82, 107),
  //                       ),
  //                     ),
  //                     focusedBorder: const OutlineInputBorder(
  //                         borderSide: BorderSide(color: Color(0xff0f969c))),
  //                     focusColor: const Color(0xff0f969c),
  //                     labelText: "Enter the URL of the image",
  //                   ),
  //                   controller: textEditingController,
  //                   focusNode: focusNode,
  //                   onSubmitted: (_) {
  //                     _onSearch(textEditingController.text);
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _showSearchBar() async {
    final TextEditingController textEditingController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    await Future.delayed(const Duration(milliseconds: 10));
    await Get.bottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 10, 45, 52),
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Expanded(
                child: TextField(
                  cursorColor: const Color(0xff0f969c),
                  style: const TextStyle(color: Color(0xff0f969c)),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(104, 15, 149, 156),
                        ),
                        child: IconButton(
                            color: const Color(0xff0f969c),
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              _onSearch(textEditingController.text);
                            }),
                      ),
                    ),
                    hintText: 'Paste URL of the Image',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(124, 15, 149, 156), fontSize: 15),
                    labelStyle: const TextStyle(color: Color(0xff0f969c)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 32, 82, 107),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0f969c))),
                    focusColor: const Color(0xff0f969c),
                    labelText: "Enter the URL of the image",
                  ),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (_) {
                    _onSearch(textEditingController.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final ImagePicker picker = ImagePicker();

    Future<void> selectFile(XFile? xFile) async {
      if (xFile != null) {
        Get.to(
          () => ImageViewerScreen.xFile(xFile: xFile),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.to(() => const Home());
      }
    }

    switch (widget.type) {
      case ChooseImageButtonType.camera:
        return ChooseImageButton.customized(
          buttonText: const Text("Camera",
              style: TextStyle(fontSize: 25, color: Colors.white)),
          lottie: LottieBuilder.asset("assets/animation/5849-camera-icon.json",
              height: height * 0.157),
          onTap: () async {
            try {
              final XFile? image =
                  await picker.pickImage(source: ImageSource.camera);

              selectFile(image);
            } on Exception {
              if (await Permission.camera.request().isDenied == true) {
                Get.snackbar(
                  "Alert",
                  "please allow ModifAi to access Camera",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
                await Permission.camera.request();
              } else if (await Permission.camera
                      .request()
                      .isPermanentlyDenied ==
                  true) {
                Get.snackbar(
                  "Alert",
                  "You have denied access to Camera permanently, please allow storage permission from settings manually",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
            }
          },
        );
      case ChooseImageButtonType.gallery:
        return ChooseImageButton.customized(
          buttonText: const Text("Gallery",
              style: TextStyle(fontSize: 25, color: Colors.white)),
          lottie: LottieBuilder.asset(
              "assets/animation/Gallery Animation-77382-photo.json",
              height: height * 0.157),
          onTap: () async {
            if (await Permission.photos.request().isGranted == true ||
                await Permission.storage.request().isGranted == true) {
              Get.to(() => const Gallery());
            } else if (await Permission.photos.request().isPermanentlyDenied ==
                    true ||
                await Permission.storage.request().isPermanentlyDenied ==
                    true) {
              Get.snackbar(
                "Alert",
                "You have denied access to Gallery/Storage permanently, please allow storage permission from settings manually",
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            } else if (await Permission.photos.request().isDenied == true ||
                await Permission.storage.request().isDenied == true) {
              Get.snackbar(
                "Alert",
                "please allow ModifAi to access Gallery/Storage",
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
              await Permission.photos.request();
              await Permission.storage.request();
            }
          },
        );
      case ChooseImageButtonType.file:
        return ChooseImageButton.customized(
          buttonText: const Text("File",
              style: TextStyle(fontSize: 23.4, color: Colors.white)),
          lottie: LottieBuilder.asset(
              "assets/animation/5536-document-file.json",
              height: height * 0.161),
          onTap: () async {
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            selectFile(image);
          },
        );
      case ChooseImageButtonType.search:
        return ChooseImageButton.customized(
            buttonText: const Text("Search",
                style: TextStyle(fontSize: 23, color: Colors.white)),
            lottie: LottieBuilder.asset(
              "assets/animation/89600-search-icon.json",
              height: height * 0.161,
            ),
            onTap: () async {
              _showSearchBar();
            });
      default:
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: height * 0.2,
            width: width * 0.36,
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                  blurStyle: BlurStyle.normal,
                  blurRadius: 3,
                  color: Color.fromARGB(255, 219, 218, 218),
                ),
                BoxShadow(
                  offset: Offset(0, 2),
                  spreadRadius: 1,
                  blurStyle: BlurStyle.normal,
                  blurRadius: 8,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 151, 195, 218),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [widget.lottie!, widget.buttonText!],
                  ),
                )
              ],
            ),
          ),
        );
    }
  }
}
