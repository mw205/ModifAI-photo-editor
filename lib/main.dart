import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dependency_injection.dart';
import 'modifai_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.init();
  Get.testMode = true;

  runApp(const ModifAiApp());
}
