import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/modifai_bot.dart';
import 'package:modifai/screens/output_image.dart';
import 'package:modifai/services/ads.dart';
import 'package:modifai/services/media.dart';

enum ModifAiFunctionsButtonsType { removebg, modifaibot, cropper }

class ModifAiFunctionsButtons extends StatefulWidget {
  final ModifAiFunctionsButtonsType? type;
  final Widget lottie;
  final double? buttonwidth;
  final VoidCallback? onTap;
  final Widget text;
  final String? photoId;
  final List<Color> colorgradientlist;
  final bool isUploaded;

  ModifAiFunctionsButtons.type({
    Key? key,
    required this.type,
    required this.photoId,
    required this.isUploaded,
  })  : lottie = Container(),
        colorgradientlist = const [],
        onTap = null,
        buttonwidth = null,
        text = Container(),
        super(key: key);

  const ModifAiFunctionsButtons.customized({
    Key? key,
    required this.onTap,
    required this.lottie,
    required this.colorgradientlist,
    required this.buttonwidth,
    required this.text,
    required this.photoId,
    required this.isUploaded,
  })  : type = null,
        super(key: key);

  @override
  State<ModifAiFunctionsButtons> createState() =>
      _ModifAiFunctionsButtonsState();
}

class _ModifAiFunctionsButtonsState extends State<ModifAiFunctionsButtons> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      initInterstitialAd();
    }
    super.initState();
  }

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdsManager.outputInterstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (error) {
            interstitialAd.dispose();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    late String? mediaUrl;
    switch (widget.type) {
      case ModifAiFunctionsButtonsType.cropper:
        return ModifAiFunctionsButtons.customized(
          isUploaded: widget.isUploaded,
          photoId: widget.photoId,
          onTap: () async {
            if (widget.isUploaded == false) {
              Get.snackbar(
                "Alert",
                "The photo is not uploded yet, please wait",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              DialogUtils.modifAiProgressindicator();
              mediaUrl = await Media.cropping(photoId: widget.photoId!);
              if (mediaUrl != null) {
                Get.back();
                if (isAdLoaded &&
                    Theme.of(context).platform == TargetPlatform.android) {
                  Get.back();
                  await interstitialAd.show();
                  Get.to(() => ShowOutputImage(mediaUrl: mediaUrl!));
                } else {
                  Get.back();
                  Get.to(() => ShowOutputImage(mediaUrl: mediaUrl!));
                }
              } else {
                Get.back();
                Get.snackbar(
                  "Alert",
                  "There is an error in our servers 😔!! try again later ",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
          lottie: LottieBuilder.asset("assets/animation/animation_cropper.json",
              height: height * 0.1, width: width * 0.2),
          colorgradientlist: const [
            Color(0xff0A4D68),
            Color(0xff088395),
            Color(0xff05BFDB),
          ],
          buttonwidth: width * 0.45,
          text: const Padding(
            padding: EdgeInsets.only(left: 0.2, bottom: 9),
            child: Text(
              "Cropper",
              style: TextStyle(color: Colors.white, fontSize: 19.5),
            ),
          ),
        );
      case ModifAiFunctionsButtonsType.removebg:
        return ModifAiFunctionsButtons.customized(
          photoId: widget.photoId,
          onTap: () async {
            if (widget.isUploaded == false) {
              Get.snackbar(
                "Alert",
                "The photo is not uploded yet, please wait",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              DialogUtils.modifAiProgressindicator();
              mediaUrl = await Media.removerbg(photoId: widget.photoId!);
              if (mediaUrl != null) {
                Get.back();
                if (isAdLoaded &&
                    Theme.of(context).platform == TargetPlatform.android) {
                  Get.back();
                  await interstitialAd.show();
                  Get.to(() => ShowOutputImage(mediaUrl: mediaUrl!));
                } else {
                  Get.back();
                  Get.to(() => ShowOutputImage(mediaUrl: mediaUrl!));
                }
              } else {
                Get.back();
                Get.snackbar(
                  "Alert",
                  "There is an error in our servers 😔!! try again later ",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
          lottie: LottieBuilder.asset("assets/animation/88214-removeBG.json",
              height: height * 0.080, width: width * 0.1944),
          colorgradientlist: const [
            Color(0xff3F3B6C),
            Color(0xff624F82),
            Color(0xff9F73AB),
          ],
          buttonwidth: width * 0.45,
          text: const Padding(
            padding: EdgeInsets.only(left: 0.2, bottom: 9),
            child: Text(
              "Remove\nBackground",
              style: TextStyle(color: Colors.white, fontSize: 16.5),
            ),
          ),
          isUploaded: widget.isUploaded,
        );
      case ModifAiFunctionsButtonsType.modifaibot:
        return ModifAiFunctionsButtons.customized(
          photoId: widget.photoId,
          isUploaded: widget.isUploaded,
          onTap: () async {
            if (widget.photoId == null) {
              Get.snackbar(
                "Alert",
                "The photo is not uploded yet, please wait",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              DialogUtils.modifAiProgressindicator();
              mediaUrl = await Media.getMedia(photoId: widget.photoId!);
              if (mediaUrl != null) {
                Get.back();
                Get.to(() => ModifAiBotPage(
                      mediaUrl: mediaUrl!,
                      photoId: widget.photoId!,
                    ));
              } else {
                Get.back();
                Get.snackbar(
                  "Alert",
                  "There is an error in our servers 😔!! try again later ",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
          lottie: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: LottieBuilder.asset(
              "assets/animation/98042-robot.json",
              height: height * 0.080,
            ),
          ),
          colorgradientlist: const [
            Color(0xff7149C6),
            Color(0xffFE6244),
            Color(0xffFC2947),
          ],
          buttonwidth: width * 0.92,
          text: const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ModifAI bot",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "tell the bot what you want to change",
                    style: TextStyle(
                        color: Color.fromARGB(210, 255, 255, 255),
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        );
      default:
        return GestureDetector(
          onTap: () {
            widget.onTap!();
          },
          child: Container(
            height: height * 0.104,
            width: widget.buttonwidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: widget.colorgradientlist),
            ),
            child: Row(
              children: [widget.lottie, widget.text],
            ),
          ),
        );
    }
  }
}
