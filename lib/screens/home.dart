// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:modifai/components/Home/choose_image_button.dart';
import 'package:modifai/components/Home/drawer/modifai_drawer_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:modifai/services/ads.dart';

import '../components/Home/drawer/modifai_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      initBannerAd();
    }
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
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff05161A),
      drawer: const ModifAIDrawer(),
      appBar: AppBar(
        leading: const ModifAiDrawerButton(),
        backgroundColor: const Color(0xff05161A),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ModifAiText(text: "Home", fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.09,
                ),
                ChooseImageButton.type(type: ChooseImageButtonType.gallery),
                SizedBox(
                  width: width * 0.1,
                ),
                ChooseImageButton.type(type: ChooseImageButtonType.camera)
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Stack(
              children: [
                Row(children: [
                  SizedBox(
                    width: width * 0.55,
                  ),
                  ChooseImageButton.type(type: ChooseImageButtonType.file)
                ]),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.089,
                    ),
                    ChooseImageButton.type(type: ChooseImageButtonType.search)
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                LottieBuilder.asset(
                    "assets/animation/90531-thin-background-lines-stripes-loop.json")
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar:
          isAdLoaded && Theme.of(context).platform == TargetPlatform.android
              ? SizedBox(
                  height: bannerAd.size.height.toDouble()+ height*80/height,
                  width: bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd),
                )
              : const SizedBox(),
    );
  }
}
