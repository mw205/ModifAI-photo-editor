import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/components/Registeration/custom_button.dart';
import 'package:modifai/components/Registeration/custom_textfield.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:modifai/controller/login_controller.dart';
import 'package:modifai/screens/sign_up_page.dart';
import 'package:modifai/services/authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController myController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      appBar: AppBar(
        title: const ModifAiText(
          text: "Sign In",
          fontSize: 33,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff05161A),
        leading: const Padding(
          padding: EdgeInsets.only(left: 6.0, top: 8),
          child: ModifAiBackButton(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03),
          child: ListView(children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomTextField.type(type: CustomTextFieldType.email),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField.type(
                  type: CustomTextFieldType.password,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            surfaceTintColor: Colors.black),
                        onPressed: () {
                          Get.to(() => const SignUpPage());
                        },
                        child: TextButton(
                          child: Text(
                            "Forget password ?",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 121, 183, 213),
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {
                            DialogUtils.modifAiProgressindicator();
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: myController.email.value);
                            Get.back();
                            Get.snackbar(
                              "Alert",
                              'An Email sent to you to reset your password, Check your inbox',
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                CustomButton(
                  buttonString: "Sign In",
                  onTap: () async {
                    await Authentication.signInWithEmailAndPassword(
                        emailAddress: myController.email.value,
                        password: myController.password.value);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            surfaceTintColor: Colors.black),
                        onPressed: () {
                          Get.to(() => const SignUpPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 121, 183, 213),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
