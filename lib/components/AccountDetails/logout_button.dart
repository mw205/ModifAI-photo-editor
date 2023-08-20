import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';

import '../../screens/registration.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (FirebaseAuth.instance.currentUser != null) {
          DialogUtils.modifAiProgressindicator();
          await FirebaseAuth.instance.signOut();
          Get.offAll(() => const Registration());
          Get.snackbar(
            "Alert",
            "You are not signed in now, please register to access all the features",
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            "Alert",
            "This account is for demo version this feature is disabled",
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      child: const Text(
        'Logout',
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
    );
  }
}
