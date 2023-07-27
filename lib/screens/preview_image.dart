// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modifai/components/ImageViewer/image_loader.dart';
import 'package:modifai/components/ImageViewer/modifai_check.dart';
import 'package:modifai/components/ImageViewer/modifai_failed.dart';
import 'package:modifai/components/ImageViewer/modifai_functions_buttons.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:modifai/screens/gallery.dart';
import 'package:modifai/screens/home.dart';
import 'package:modifai/services/media.dart';
import 'package:photo_manager/photo_manager.dart';

import '../components/ImageViewer/uploading_indicator.dart';
import '../services/ads.dart';

class ImageViewerScreen extends StatefulWidget {
  AssetEntity? asset;
  Future<Uint8List?>? data;
  XFile? xFile;
  File? file;
  late bool isShared = false;
  late bool isFromGallery = false;
  late bool isFromSearch = false;
  ImageViewerScreen.asset({
    super.key,
    required this.asset,
  }) {
    isFromGallery = true;
  }
  ImageViewerScreen.xFile({super.key, required this.xFile});
  ImageViewerScreen.data({
    super.key,
    required this.data,
  }) {
    isFromSearch = true;
  }
  ImageViewerScreen.file({
    super.key,
    required this.file,
  }) {
    isShared = true;
  }

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  Future<Uint8List?>? _imageData;

  bool isUploading = false;
  bool isUploaded = false;
  bool isNotUploaded = false;
  String? photoId;

  @override
  void initState() {
    super.initState();
    _uploadingImageData();
    _loadImageData();
    if (Platform.isAndroid) {
      initBannerAd();
    }
  }

  void _loadImageData() async {
    if (widget.asset != null) {
      final assetFile = await widget.asset!.file;
      setState(() {
        _imageData = assetFile!.readAsBytes();
      });
    } else if (widget.xFile != null) {
      setState(() {
        _imageData = widget.xFile!.readAsBytes();
      });
    } else if (widget.data != null) {
      _imageData = widget.data;
    } else if (widget.file != null) {
      _imageData = widget.file!.readAsBytes();
    }
  }

  void _uploadingImageData() async {
    if (widget.asset != null) {
      setState(() {
        isUploading = true;
      });
      photoId = await Media.uploadImage(file: await widget.asset!.file);
      if (isUploading == true && photoId != null) {
        if (photoId == "") {
          setState(() {
            isNotUploaded = true;
            isUploaded = false;
            isUploading = false;
          });
        } else {
          setState(() {
            isUploading = false;
            isUploaded = true;
            isNotUploaded = false;
          });
        }
      }
    } else if (widget.xFile != null) {
      setState(() {
        isUploading = true;
      });

      photoId = await Media.uploadImage(xFile: widget.xFile);
      if (isUploading == true && photoId != null) {
        if (photoId == "") {
          setState(() {
            isNotUploaded = true;
            isUploaded = false;
            isUploading = false;
          });
        } else {
          setState(() {
            isUploading = false;
            isUploaded = true;
            isNotUploaded = false;
          });
        }
      }
    } else if (widget.data != null) {
      setState(() {
        isUploading = true;
      });
      photoId = await Media.uploadImage(data: widget.data);
      if (isUploading == true && photoId != null) {
        if (photoId == "") {
          setState(() {
            isNotUploaded = true;
            isUploaded = false;
            isUploading = false;
          });
        } else {
          setState(() {
            isUploading = false;
            isUploaded = true;
            isNotUploaded = false;
          });
        }
      }
    } else if (widget.file != null) {
      setState(() {
        isUploading = true;
      });

      photoId = await Media.uploadImage(file: widget.file);
      if (isUploading == true && photoId != null) {
        if (photoId == "") {
          setState(() {
            isNotUploaded = true;
            isUploaded = false;
            isUploading = false;
          });
        } else {
          setState(() {
            isUploading = false;
            isUploaded = true;
            isNotUploaded = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    isUploading = false; // stop uploading media
    super.dispose();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.imageViewerBannerAdId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            bannerAd.dispose();
          },
        ),
        request: const AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      appBar: AppBar(
        backgroundColor: const Color(0xff05161A),
        leading: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 8),
            child: ModifAiBackButton(
              onTap: () {
                if (widget.isShared) {
                  Get.to(() => const Home());
                } else if (widget.isFromSearch) {
                  Get.to(() => const Home());
                } else {
                  Get.off(() => const Gallery());
                }
              },
            )),
        title: const ModifAiText(text: "Image Viewer", fontSize: 35),
        centerTitle: true,
        actions: [
          if (isUploading)
            const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: UploadingIndicator()),
          if (isUploaded && !isUploading) const ModifAiCheck(),
          if (isNotUploaded) const ModifAiFailed()
        ],
      ),
      body: Column(
        children: [
          if (isAdLoaded &&
              Theme.of(context).platform == TargetPlatform.android)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: AdWidget(ad: bannerAd),
            )
          else
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
          Center(
            child: ImageLoader(
              imageData: _imageData,
              height: height * 0.55,
              width: width * 0.95,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8.0),
            child: Row(
              children: [
                ModifAiFunctionsButtons.type(
                  type: ModifAiFunctionsButtonsType.cropper,
                  photoId: photoId,
                  isUploaded: isUploaded,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ModifAiFunctionsButtons.type(
                    type: ModifAiFunctionsButtonsType.removebg,
                    photoId: photoId,
                    isUploaded: isUploaded,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ModifAiFunctionsButtons.type(
              type: ModifAiFunctionsButtonsType.modifaibot,
              photoId: photoId,
              isUploaded: isUploaded,
            ),
          ),
        ],
      ),
    );
  }
}
