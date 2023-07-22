
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../screens/no_internet.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoInternet());
    } else {
      Get.back();
    }
  }
}
