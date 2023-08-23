import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPI {
  static Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //final accessToken = facebookAuthCredential.accessToken;
    // Sign in with the credential
    DialogUtils.modifAiProgressindicator();
    Get.snackbar(
      "Alert",
      "Signing you in, please wait!!",
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    final userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    // Return the Account object
    final user = userCredential.user;
    if (user != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString("access_token") != null) {
        Get.offAll(() => const Home());
      } else {
        await getModifaiAccessToken();
        if (sharedPreferences.getString("access_token") != null) {
          Get.offAll(() => const Home());
        } else {
          Get.back();
          Get.snackbar(
            "Alert",
            "please try again",
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    } else {
      Get.snackbar(
        "Alert",
        "please try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    return null;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final usergooglecredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
    );

    // Once signed in, return the UserCredential
    try {
      await FirebaseAuth.instance.signInWithCredential(usergooglecredential);
      if (FirebaseAuth.instance.currentUser != null) {
        DialogUtils.modifAiProgressindicator();
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.getString("access_token") != null) {
          Get.offAll(() => const Home());
        } else {
          await getModifaiAccessToken();
          if (sharedPreferences.getString("access_token") != null) {
            Get.offAll(() => const Home());
          } else {
            Get.snackbar(
              "Alert",
              "There is an error here you can use another sign-in method",
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else {
        Get.snackbar(
          "Alert",
          "There is an error here you can use another sign-in method",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
      return null;
    } catch (e) {
      Get.snackbar(
        "Alert",
        "There is an error here you can use another sign-in method",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }

  static Future<String?> getModifaiAccessToken() async {
    String? provider;
    String? providername;

    for (final providerProfile
        in FirebaseAuth.instance.currentUser!.providerData) {
      // ID of the provider (google.com, apple.com, etc.)
      provider = providerProfile.uid;
      providername = providerProfile.providerId.replaceAll(".com", "");
    }
    Uri url = Uri.parse(
        "https://modifai.onrender.com/api/auth/firebase/$providername ");
    final request = await http.post(url, body: {
      "id": FirebaseAuth.instance.currentUser!.uid,
      "name": FirebaseAuth.instance.currentUser!.displayName,
      "email": FirebaseAuth.instance.currentUser!.email,
      "providerAccountId": provider
    }, headers: {
      'Accept': 'application/json',
    });
    if (request.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(request.body);
      String accessToken = responseMap['access_token'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", accessToken);
      return accessToken;
    } else {
      return null;
    }
  }
}
