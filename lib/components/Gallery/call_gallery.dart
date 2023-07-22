import 'package:flutter/material.dart';
import 'package:modifai/components/Gallery/gallery_content.dart';

class CallGallery extends StatefulWidget {
  const CallGallery({super.key});

  @override
  State<CallGallery> createState() => _CallGalleryState();
}

class _CallGalleryState extends State<CallGallery> {
  GalleryContent gallery = const GalleryContent();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.028,
                vertical: MediaQuery.of(context).size.height * 0.025,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 33, 72, 93),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const GalleryContent(),
            ),
          )
        ],
      ),
    );
  }
}
