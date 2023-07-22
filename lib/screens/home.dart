// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modifai/components/Home/choose_image_button.dart';
import 'package:modifai/components/Home/drawer/modifai_drawer_button.dart';
import 'package:modifai/components/modifai_text.dart';

import '../components/Home/drawer/modifai_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff05161A),
      drawer: const ModifAIDrawer(),
      appBar: AppBar(
        leading: const ModifAiDrawerButton(),
        backgroundColor: const Color(0xff05161A),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ModifAiText(text: "Home", fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.09,
                ),
                ChooseImageButton.type(type: ChooseImageButtonType.gallery),
                SizedBox(
                  width: width * 0.1,
                ),
                ChooseImageButton.type(type: ChooseImageButtonType.camera)
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Stack(
              children: [
                Row(children: [
                  SizedBox(
                    width: width * 0.55,
                  ),
                  ChooseImageButton.type(type: ChooseImageButtonType.file)
                ]),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.089,
                    ),
                    ChooseImageButton.type(type: ChooseImageButtonType.search)
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            LottieBuilder.asset(
                "assets/animation/90531-thin-background-lines-stripes-loop.json")
          ],
        ),
      ),
    );
  }
}
