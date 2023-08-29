import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/screens/login_page.dart';
import 'package:modifai/services/authentication.dart';

enum AutoRegisterButtonType { password, google }

class AutoRegisterButton extends StatelessWidget {
  late final Color? color;
  late final Text? buttonText;
  late final Icon? icon;
  late final VoidCallback? onTap;
  late final Image? image;
  late final AutoRegisterButtonType? type;
  AutoRegisterButton.type({super.key, required this.type}) {
    color = null;
    buttonText = null;
    icon = null;
    image = null;
    onTap = null;
  }
  AutoRegisterButton.customized({
    super.key,
    required this.color,
    required this.buttonText,
    this.image,
    this.icon,
    required this.onTap,
  }) {
    assert(image != null || icon != null);
    type = null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    switch (type) {
      case AutoRegisterButtonType.password:
        return AutoRegisterButton.customized(
          icon: Icon(
            Icons.person,
            color: Colors.black,
            size: width * 0.06,
          ),
          color: Colors.white,
          buttonText: Text(
            "Continue with Email & Password",
            style: TextStyle(
              color: Colors.black,
              fontSize: (MediaQuery.of(context).size.width * 0.7) / 16.75,
            ),
          ),
          onTap: () async {
            Get.to(const LoginPage());
            // AuthAPI.signInWithFacebook();
          },
        );
      case AutoRegisterButtonType.google:
        return AutoRegisterButton.customized(
          image: Image.asset(
            "assets/images/google-logo-9808.png",
            width: MediaQuery.of(context).size.width * 0.07,
            height: MediaQuery.of(context).size.width * 0.07,
          ),
          color: Colors.white,
          buttonText: Text(
            "Continue with Google",
            style: TextStyle(
                color: Colors.black,
                fontSize: (MediaQuery.of(context).size.width * 0.7) / 16),
          ),
          onTap: () {
            Authentication.signInWithGoogle();
          },
        );
      default:
        return GestureDetector(
          onTap: () async {
            onTap!();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.125),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: const Color.fromARGB(255, 246, 246, 246),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: Row(
                children: [
                  if (image != null) image! else icon!,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: buttonText!,
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
