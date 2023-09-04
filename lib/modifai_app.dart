import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/screens/preview_image.dart';
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
    handler.sharedMediaStream.listen((SharedMedia media) async {
      await _handleSharedMedia(media);
    });
  }

  Future<void> _handleSharedMedia(SharedMedia media) async {
    if (media.attachments != null &&
        media.attachments!.any(
            (attachment) => attachment?.type == SharedAttachmentType.image)) {
      List<File> sharedImageFiles = [];

      for (SharedAttachment? attachment in media.attachments!) {
        if (attachment?.type == SharedAttachmentType.image) {
          final file = File(attachment!.path);
          sharedImageFiles.add(file);
        }
      }

      if (sharedImageFiles.isNotEmpty) {
        setState(() {
          _sharedMedia = media;
        });
        // Pass the list of shared image files to the ImageViewerScreen
        Get.to(ImageViewerScreen.file(file: sharedImageFiles.first));
      }
    } else {
      Get.snackbar(
        "Alert",
        "Invalid Shared Media !!",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  bool isReceivedMediaAnImage() {
    return _sharedMedia != null &&
        _sharedMedia!.attachments != null &&
        _sharedMedia!.attachments!.any(
            (attachment) => attachment?.type == SharedAttachmentType.image);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
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
}
