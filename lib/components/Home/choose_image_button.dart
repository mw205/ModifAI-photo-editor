import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
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
        Future<Uint8List?> imageData = Media.loadImageData(imageUrl);
        Get.to(() => ImageViewerScreen.data(data: imageData));
      }
    }
  }

  Future<void> _showAlertDialog() async {
    final TextEditingController textEditingController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 10, 45, 52),

          // <-- SEE HERE
          title: const Text(
            'Search',
            style: TextStyle(fontSize: 23, color: Color(0xff0f969c)),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              cursorColor: const Color(0xff0f969c),
              style: const TextStyle(color: Color(0xff0f969c)),
              decoration: const InputDecoration(
                hintText: 'Paste URL of the Image',
                hintStyle: TextStyle(
                    color: Color.fromARGB(124, 15, 149, 156), fontSize: 15),
                labelStyle:
                    TextStyle(color: Color(0xff0f969c), fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 32, 82, 107),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0f969c))),
                focusColor: Color(0xff0f969c),
                labelText: "URL of the image",
              ),
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (_) {
                _onSearch(textEditingController.text);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff0f969c),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
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
            Padding(
              padding: const EdgeInsets.only(right: 45.0),
              child: TextButton(
                child: const Text(
                  'Paste',
                  style: TextStyle(
                    color: Color(0xff0f969c),
                  ),
                ),
                onPressed: () {
                  FlutterClipboard.paste().then((value) {
                    // Do what ever you want with the value.
                    setState(() {
                      textEditingController.text = value;
                    });
                  });
                },
              ),
            ),
          ],
        );
      },
    );
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
              _showAlertDialog();
              //_showSearchBar();
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
