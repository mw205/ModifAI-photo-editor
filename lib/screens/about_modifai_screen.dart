import 'package:flutter/material.dart';
import 'package:modifai/components/AboutDetails/about_modifai_list_tile.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/modifai_text.dart';

class AboutModifAiScreen extends StatefulWidget {
  const AboutModifAiScreen({super.key});

  @override
  State<AboutModifAiScreen> createState() => _AboutModifAiScreenState();
}

class _AboutModifAiScreenState extends State<AboutModifAiScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff05161A),
        leading:  const Padding(
          padding: EdgeInsets.all(4.0),
          child: ModifAiBackButton(),
        ),
        title: const ModifAiText(
          text: "About ModifAi",
          fontSize: 28,
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff05161A),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.06,
          ),
          const AboutModifAiListTile(
            questionContent: Text(
              'Can I use these designs commercially?',
              style: TextStyle(fontSize: 18.5, color: Color(0xff6da5c0)),
            ),
            answerContent: Text(
              "Certainly! If you're a user with a paid subscription that supports commercial usage, you have the rights to use the designs for commercial purposes. But remember, rights for personal and commercial use depend on the type of subscription you hold. Always ensure your usage aligns with your subscription terms.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const AboutModifAiListTile(
            questionContent: Text(
              'How do you handle my data and respect my privacy?',
              style: TextStyle(fontSize: 18.5, color: Color(0xff6da5c0)),
            ),
            answerContent: Text(
              "We take your privacy seriously and are committed to keeping your uploads confidential. We assure you that we will not publish any outputs of your account on our homepage or anywhere else without your explicit permission. We follow stringent data management practices to protect your data. For more detailed information on how we handle and protect your data, please check out our Privacy Policy.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const AboutModifAiListTile(
            answerContent: Text(
              "A. Mohammed, and M. Waleed developed ModifAI with the help of input from industry professionals. Through extensive use of AI technology while developing ModifAI, We are able to offer ModifAI's services at an affordable price while ensuring a sustainable business.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            questionContent: Text(
              'Who created ModifAI?',
              style: TextStyle(fontSize: 18.5, color: Color(0xff6da5c0)),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.25,
                child: Image.asset(
                  "assets/images/modifai1.png",
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              const Text(
                "© 2023\nA. Mohammed, M. Waleed",
                style: TextStyle(
                  color: Color.fromARGB(118, 255, 255, 255),
                  fontSize: 18,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
