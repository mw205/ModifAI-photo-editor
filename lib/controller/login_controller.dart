import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool remember = false.obs;
  RxBool obsecure = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString name = ''.obs;
  RxString profilePhotoUrl = ''.obs;

  void setPassword(String value) {
    password.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setName(String value) {
    name.value = value;
  }

  void setProfilePhotoUrl(String value) {
    profilePhotoUrl.value = value;
  }

  void toggleRememberMe() {
    remember.value = !remember.value;
  }

  void toggleObscure() {
    obsecure.value = !obsecure.value;
  }
}
