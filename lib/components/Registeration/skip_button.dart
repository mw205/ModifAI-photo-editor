import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/home.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  void generateGuestId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("guestId") == null) {
      String guestId =
          "${info.brand}${info.device}${DateTime.now().millisecondsSinceEpoch.toString()}";
      await prefs.setString('guestId', guestId);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            generateGuestId();
            Get.off(() => const Home());
          },
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.white, fontSize: width * .060),
          ),
        ),
      ],
    );
  }
}
