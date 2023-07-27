import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modifai/components/Gallery/gallery_content.dart';
import 'package:modifai/services/ads.dart';

class CallGallery extends StatefulWidget {
  const CallGallery({super.key});

  @override
  State<CallGallery> createState() => _CallGalleryState();
}

class _CallGalleryState extends State<CallGallery> {
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
        adUnitId: AdsManager.galleryBannerAdId,
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

  GalleryContent gallery = const GalleryContent();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isAdLoaded &&
              Theme.of(context).platform == TargetPlatform.android)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.096,
              child: AdWidget(ad: bannerAd),
            )
          else
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.096,
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
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
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
