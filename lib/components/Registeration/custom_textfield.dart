import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:modifai/controller/login_controller.dart';

enum CustomTextFieldType { email, password, name }

class CustomTextField extends StatelessWidget {
  late final String? hintText;
  late final Widget? suffixIcon;
  late final Function(String)? onChanged;
  late final bool? obscureText;
  late final CustomTextFieldType? type;
  late final TextEditingController? textEditingController;
  CustomTextField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.suffixIcon,
      this.obscureText,
      this.textEditingController}) {
    type = null;
  }
  CustomTextField.type({super.key, required this.type}) {
    hintText = "";
    suffixIcon = null;
    onChanged = (p0) {};
    obscureText = false;
    textEditingController = null;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CustomTextFieldType.email:
        return GetX<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return CustomTextField(
              obscureText: false,
              hintText: "Email",
              suffixIcon: SizedBox(
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
              textEditingController:
                  TextEditingController(text: controller.email.value),
              onChanged: (value) {
                controller.setEmail(value);
              },
            );
          },
        );
      case CustomTextFieldType.name:
        return GetX<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return CustomTextField(
              obscureText: false,
              hintText: "Name",
              textEditingController:
                  TextEditingController(text: controller.email.value),
              onChanged: (value) {
                controller.setName(value);
              },
            );
          },
        );
      case CustomTextFieldType.password:
        return GetX<LoginController>(
          init: LoginController(),
          builder: (controller) => CustomTextField(
            obscureText: controller.obsecure.value,
            hintText: "Password",
            suffixIcon: SizedBox(
              child: IconButton(
                onPressed: () {
                  controller.toggleObscure();
                },
                icon: controller.obsecure.value
                    ? Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.03,
                      )
                    : Icon(
                        Icons.password,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
              ),
            ),
            textEditingController:
                TextEditingController(text: controller.password.value),
            onChanged: (value) {
              controller.setPassword(value);
            },
          ),
        );
      default:
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        obscureText: obscureText!,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.04),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.height * 0.02),
          label: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              hintText!,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(133, 255, 255, 255)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 42, 64, 74),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff6da5c0),
          )),
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
