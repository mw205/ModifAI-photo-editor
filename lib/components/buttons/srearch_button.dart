import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/preview_image.dart';

import '../../services/media.dart';

class SearchButton extends StatefulWidget {
  final String imgUrl;
  const SearchButton({super.key, required this.imgUrl});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(104, 15, 149, 156),
      ),
      child: IconButton(
          color: const Color(0xff0f969c),
          icon: const Icon(Icons.search),
          onPressed: () {
            _onSearch(widget.imgUrl);
          }),
    );
  }
}
