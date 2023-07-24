import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/Gallery/call_gallery.dart';
import 'package:modifai/screens/home.dart';

import '../components/buttons/modifai_back_button.dart';
import '../components/modifai_text.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      appBar: AppBar(
        backgroundColor: const Color(0xff05161A),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ModifAiText(text: "Gallery", fontSize: 40),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 8),
          child: ModifAiBackButton(
            onTap: () {
              Get.offAll(() => const Home());
            },
          ),
        ),
      ),
      body: const CallGallery(),
    );
  }
}
