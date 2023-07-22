import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/screens/account_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/about_modifai_screen.dart';

class ModifAIDrawer extends StatefulWidget {
  const ModifAIDrawer({super.key});

  @override
  State<ModifAIDrawer> createState() => _ModifAIDrawerState();
}

class _ModifAIDrawerState extends State<ModifAIDrawer> {
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://modifai.onrender.com/"))) {
      throw Exception('Could not launch "https://modifai.onrender.com/"');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff05161A),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Image.asset(
              "assets/images/modifai1.png",
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Account',
                style: TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  Get.to(() => const AccountDetails());
                }
              }),
          ListTile(
            leading: const Icon(
              Icons.rate_review,
              color: Colors.white,
            ),
            title: const Text(
              'Rate us',
              style: TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Share with your friends',
              style: TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
            ),
            onTap: () {
              try {
                launchUrl(Uri.parse(
                    'https://play.google.com/store/apps/details?id=market://details?id=com.example.modifai'));
              } catch (e) {
                launchUrl(Uri.parse("https://modifai.onrender.com/"));
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.chrome_reader_mode_rounded,
              color: Colors.white,
            ),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
            ),
            onTap: () {
              Get.to(() => const AboutModifAiScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.web_asset,
              color: Colors.white,
            ),
            title: const Text(
              'Go to our website',
              style: TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
            ),
            onTap: () {
              _launchUrl();
            },
          ),
        ],
      ),
    );
  }
}
