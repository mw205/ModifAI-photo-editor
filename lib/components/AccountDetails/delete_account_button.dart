import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/components/confirmation_dialog.dart';

import '../../screens/registration.dart';

class DeleteAccountButton extends StatefulWidget {
  const DeleteAccountButton({super.key});

  @override
  State<DeleteAccountButton> createState() => _DeleteAccountButtonState();
}

class _DeleteAccountButtonState extends State<DeleteAccountButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Get.dialog(
          ConfirmationDialog(
            onConfirm: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                DialogUtils.modifAiProgressindicator();
                await FirebaseAuth.instance.currentUser!.delete();
                Get.offAll(() => const Registration());
                Get.snackbar(
                  "Alert",
                  "Your account is deleted now, please register to access all the features",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        );
      },
      child: const Text(
        'Delete Account',
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
    );
  }
}
