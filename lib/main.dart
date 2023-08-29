import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modifai/controller/bot_controller.dart';
import 'package:modifai/controller/login_controller.dart';

import 'dependency_injection.dart';
import 'modifai_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  DependencyInjection.init();
  Get.put(LoginController());
  Get.put(BotController());
  Get.testMode = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ModifAiApp());
  });
}
