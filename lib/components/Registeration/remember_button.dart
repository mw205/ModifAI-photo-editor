import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/controller/login_controller.dart';

class RememberButton extends StatelessWidget {
  const RememberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            side: const BorderSide(
              color: Color(0xff17C3CE),
            ),
            activeColor: const Color(0xff17C3CE),
            value: controller.remember.value,
            onChanged: (bool? value) {
              controller.toggleRememberMe();
            },
          ),
          TextButton(
            onPressed: () {
              controller.toggleRememberMe();
            },
            child: const Text(
              "Remember me",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
