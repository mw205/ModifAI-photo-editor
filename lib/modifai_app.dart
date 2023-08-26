import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/screens/splash.dart';
import 'package:share_handler/share_handler.dart';

class ModifAiApp extends StatefulWidget {
  const ModifAiApp({Key? key}) : super(key: key);

  @override
  State<ModifAiApp> createState() => _ModifAiAppState();
}

class _ModifAiAppState extends State<ModifAiApp> {
  SharedMedia? _sharedMedia;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final handler = ShareHandler.instance;
    final initialMedia = await handler.getInitialSharedMedia();
    if (initialMedia != null) {
      await _handleSharedMedia(initialMedia);
    }
//this is used to check if there are shared media when the app is in the memory
    handler.sharedMediaStream.listen((SharedMedia media) async {
      await _handleSharedMedia(media);
    });
  }

  Future<void> _handleSharedMedia(media) async {
    //  if the attachments are not null and there is one image at least
    if (media.attachments != null &&
        media.attachments!.any(
            (attachment) => attachment?.type == SharedAttachmentType.image)) {
      // if this condition is true then will convert the first shared image to a file from its path"if there are more than
      //  an image will take the first one" , then take the image's file and pass it to image view screen to show it there

      final file = File(media.attachments!
          .firstWhere(
              (attachment) => attachment?.type == SharedAttachmentType.image)!
          .path);
      setState(() {
        _sharedMedia = media;
      });
    } else {
      //to ensure that the app woll not deal with links that dosn't have photos
      Get.snackbar(
        "Alert",
        "Please share images only!!",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

//this function will deal with links and return true only if the link has a photo
  bool isReceivedMediaAnimage() {
    if (_sharedMedia != null &&
        _sharedMedia!.attachments != null &&
        _sharedMedia!.attachments!.any(
            (attachment) => attachment?.type == SharedAttachmentType.image)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: sharedisImage()
          ? SplashScreen.handleSharedMedia(
              imageReceived: fileHandled(),
            )
          : const SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Lato",
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(100, 15, 149, 156),
          selectionHandleColor: Color(0xff0f969c),
        ),
        indicatorColor: const Color(0xff6da5c0),
      ),
    );
  }

  File fileHandled() {
    return File(_sharedMedia!.attachments!
        .firstWhere(
            (attachment) => attachment?.type == SharedAttachmentType.image)!
        .path);
  }

  bool sharedisImage() {
    return _sharedMedia != null &&
        _sharedMedia!.attachments != null &&
        _sharedMedia!.attachments!.any(
            (attachment) => attachment?.type == SharedAttachmentType.image);
  }
}
