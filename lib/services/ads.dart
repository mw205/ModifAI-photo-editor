class AdsManager {
  static const bool testMode = true;
  static String get homeBannerAdId {
    if (testMode ==true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-3213294686132015/2900773429";
    }
  }
  static String get galleryBannerAdId {
    if (testMode ==true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-3213294686132015/6039810768";
    }
  }
  static String get imageViewerBannerAdId {
    if (testMode ==true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-3213294686132015/8864187176";
    }
  }

  static String get appId {
    return "ca-app-pub-3213294686132015~8575676470";
  }
}
