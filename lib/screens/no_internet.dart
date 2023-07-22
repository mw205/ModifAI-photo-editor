//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
                "assets/animation/91167-no-internet-connection.json",
                height: height * 0.18,
                width: width * 0.5,
                fit: BoxFit.cover),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          const Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          const Text(
            "Try Again Later",
            style: TextStyle(fontSize: 15, color: Color.fromARGB(137, 0, 0, 0)),
          )
        ],
      ),
    );
  }
}
