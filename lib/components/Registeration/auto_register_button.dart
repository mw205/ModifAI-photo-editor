import 'package:flutter/material.dart';
import 'package:modifai/services/authentication.dart';

enum AutoRegisterButtonType { facebook, google }

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
    switch (type) {
      case AutoRegisterButtonType.facebook:
        return AutoRegisterButton.customized(
          icon: const Icon(
            Icons.facebook_outlined,
            color: Colors.white,
            size: 33,
          ),
          color: Colors.blue,
          buttonText: const Text(
            "Continue with Facebook",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () async {
            AuthAPI.signInWithFacebook();
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
          buttonText: const Text(
            "Continue with Google",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onTap: () {
            AuthAPI.signInWithGoogle();
          },
        );
      default:
        return GestureDetector(
          onTap: () async {
            onTap!();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: color,
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
