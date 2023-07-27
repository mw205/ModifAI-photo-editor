// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modifai/components/ImageViewer/modifai_check.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/buttons/save_image_button.dart';
import 'package:modifai/components/buttons/share_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:modifai/services/ads.dart';
import 'package:photo_view/photo_view.dart';

class ShowOutputImage extends StatefulWidget {
  final String mediaUrl;

  const ShowOutputImage({super.key, required this.mediaUrl});

  @override
  State<ShowOutputImage> createState() => _ShowOutputImageState();
}

class _ShowOutputImageState extends State<ShowOutputImage> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      initBannerAd();
    }
    super.initState();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.homeBannerAdId,
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
    bool isSaved = false;
    saver() async {
      DialogUtils.modifAiProgressindicator();
      try {
        await GallerySaver.saveImage(widget.mediaUrl);
      } catch (e) {
        return null;
      }
      Get.back();
      setState(() {
        isSaved = true;
      });
      if (isSaved) {
        Get.snackbar(
          "Image is saved to Your gallery Now !!",
          "Thanks for using ModifAi .",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 6.0, top: 8),
          child: ModifAiBackButton(),
        ),
        backgroundColor: const Color(0xff05161A),
        centerTitle: true,
        title: const ModifAiText(
          text: "Output",
          fontSize: 35,
        ),
        actions: [
          if (!isSaved)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: SaveImageButton(onSaveImage: () {
                saver();
              }),
            ),
          if (isSaved) const ModifAiCheck(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: ShareButton(mediaUrl: widget.mediaUrl),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Center(
            child: SizedBox(
              height: height * 0.58,
              width: width * 0.95,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: PhotoView(
                  imageProvider: NetworkImage(widget.mediaUrl),
                ),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
      bottomNavigationBar:
          (isAdLoaded && Theme.of(context).platform == TargetPlatform.android)
              ? SizedBox(
                  height: AdSize.banner.height.toDouble(),
                  width: AdSize.banner.width.toDouble(),
                  child: AdWidget(ad: bannerAd),
                )
              : SizedBox(
                  height: AdSize.banner.height.toDouble(),
                  width: AdSize.banner.width.toDouble(),
                ),
    );
  }
}
