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
    /* it was necessary to add permissions to be ready as a user to use all features of the app and when this
    process is completed then we have three paths if there is an image received then we will go and show it in the
    image viewer screen else we will go to home screen if the user is signed in else then the image of registration will
    be shown and the user can skip this operation
    */
    Media.addPermissions().whenComplete(() async {
      Future.delayed(const Duration(seconds: 2), () {
        if (widget.imageReceived != null) {
          
          ImageViewerScreen.file(
            file: widget.imageReceived,
          );
        } else {
          if (FirebaseAuth.instance.currentUser != null) {
            Get.offAll(() => const Home());
          } else {
            Get.offAll(() => const Registration());
          }
        }
      });
    });
    super.initState();
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
