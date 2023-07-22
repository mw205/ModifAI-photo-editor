import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DialogUtils {
  static void modifAiProgressindicator() {
    Get.dialog(
      Center(
        child: LottieBuilder.asset(
          "assets/animation/96258-white-bouncing-dots-loader.json",
          width: Get.width * 0.5,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
