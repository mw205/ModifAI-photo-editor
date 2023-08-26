import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modifai/screens/home.dart';
import 'package:modifai/screens/preview_image.dart';
import 'package:modifai/services/media.dart';

import 'registration.dart';

class SplashScreen extends StatefulWidget {
  final File? imageReceived;
  const SplashScreen({
    super.key,
    this.imageReceived,
  });
  const SplashScreen.handleSharedMedia(
      {super.key, required this.imageReceived});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    /*if user is registered then go to home page
    and if there is a shared image then direct him to the image viewer screen
    else go to registeration page*/
    direct();
    super.initState();
  }

  void direct() {
    Media.addPermissions().whenComplete(() async {
      Future.delayed(const Duration(seconds: 2), () async {
        if (widget.imageReceived != null) {
          Get.to(() => ImageViewerScreen.file(
                file: widget.imageReceived,
              ));
        } else {
          if (FirebaseAuth.instance.currentUser != null) {
            Get.offAll(() => const Home());
          } else {
            Get.offAll(() => const Registration());
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          LottieBuilder.asset(
            "assets/animation/10201-background-full-screen-night.json",
            height: height,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * .3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/modifai1.png"),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.29,
              ),
              LottieBuilder.asset(
                "assets/animation/96258-white-bouncing-dots-loader.json",
                width: width * 0.5,
              )
            ],
          ),
        ],
      ),
    );
  }
}
