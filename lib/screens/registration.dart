import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/Registeration/auto_register_button.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          LottieBuilder.asset(
            "assets/animation/10201-background-full-screen-night.json",
            height: height,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * .30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        scale: 0.5,
                        image: AssetImage("assets/images/modifai1.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  Text(
                    "Register ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: width * 0.08),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.04, top: height * 0.05),
                      child: AutoRegisterButton.type(
                          type: AutoRegisterButtonType.facebook)),
                  Padding(
                      padding: EdgeInsets.only(
                        right: width * 0.04,
                        top: height * 0.03,
                      ),
                      child: AutoRegisterButton.type(
                          type: AutoRegisterButtonType.google)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
