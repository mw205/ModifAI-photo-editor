import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/AccountDetails/profile_photo.dart';
import 'package:modifai/components/Registeration/custom_button.dart';
import 'package:modifai/components/Registeration/custom_textfield.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:modifai/controller/login_controller.dart';
import 'package:modifai/services/authentication.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController myController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: const Color(0xff05161A),
      appBar: AppBar(
        title: const ModifAiText(
          text: "Sign Up",
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: const ProfilePhoto(
                    isSignUP: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField.type(
                  type: CustomTextFieldType.name,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                CustomTextField.type(type: CustomTextFieldType.email),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                CustomTextField.type(
                  type: CustomTextFieldType.password,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                ),
                CustomButton(
                  buttonString: "Sign Up",
                  onTap: () {
                    Authentication.signUpWithEmailAndPassword(
                        emailAddress: myController.email.value,
                        password: myController.password.value,
                        name: myController.name.value,
                        profilePhotoUrl: myController.profilePhotoUrl.value);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            surfaceTintColor: Colors.black),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Sign In",
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
