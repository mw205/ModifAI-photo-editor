import 'package:get/get.dart';

class BotController extends GetxController {
  RxString prompt = ''.obs;
  RxString selection = ''.obs;

  void setPrompt(String value) {
    prompt.value = value;
  }

  void setselection(String value) {
    selection.value = value;
  }
}
