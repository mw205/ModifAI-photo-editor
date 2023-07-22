// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../screens/preview_image.dart';
import 'wait_animation.dart';

bool? galleryEmpty = false;

class GalleryContent extends StatefulWidget {
  const GalleryContent({Key? key}) : super(key: key);
  @override
  _GalleryContentState createState() => _GalleryContentState();
}

class _GalleryContentState extends State<GalleryContent> {
  List<AssetEntity> _assets = [];
  AssetEntity? _selectedAsset;

  final albums = PhotoManager.getAssetCount();

  Future<void> _loadAssets() async {
    final albums = await PhotoManager.getAssetPathList();
    final recentAlbum = albums.first;
    final assets = await recentAlbum.getAssetListRange(start: 0, end: 1000);
    final filteredAssets =
        assets.where((asset) => asset.type != AssetType.video).toList();
    setState(() {
      _assets = filteredAssets;
    });
  }

  void _selectAsset(AssetEntity asset) {
    setState(() {
      _selectedAsset = asset;
    });
    Get.to(
      () => ImageViewerScreen.asset(asset: _selectedAsset!),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    
    return RefreshIndicator(
      color: const Color(0xff072E33),
      onRefresh: _loadAssets,
      child: GridView.builder(
        itemCount: _assets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _selectAsset(_assets[index]);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: FutureBuilder<Uint8List?>(
                future: _assets[index].thumbnailData,
                builder:
                    (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(snapshot.data!),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      _loadAssets();
                    });
                    return const ModifAiWaitAnimation();
                  } else {
                    return const ModifAiWaitAnimation();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
