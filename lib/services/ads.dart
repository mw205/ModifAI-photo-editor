class AdsManager {
  static const bool testMode = true;
  static String get bannerAdId {
    if (testMode ==true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-3213294686132015/2900773429";
    }
  }

  static String get appId {
    return "ca-app-pub-3213294686132015~8575676470";
  }
}
