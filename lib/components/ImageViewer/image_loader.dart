import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:modifai/components/Gallery/wait_animation.dart';
import 'package:photo_view/photo_view.dart';

class ImageLoader extends StatefulWidget {
  final Future<Uint8List?>? imageData;
  final double height;
  final double width;
  const ImageLoader({super.key, required this.imageData, required this.height, required this.width});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: widget.imageData,
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null) {
          return SizedBox(
            height: widget.height,
            width:  widget.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: PhotoView(
                imageProvider: MemoryImage(
                  snapshot.data!,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading image');
        } else {
          return const ModifAiWaitAnimation();
        }
      },
    );
  }
}
