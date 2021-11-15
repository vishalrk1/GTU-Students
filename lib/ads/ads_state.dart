import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  var noClicks = 0;
  var noPfClicks = 0;

  //banner id - ca-app-pub-8976724596178806/7369925229
  //interstitial id - ca-app-pub-8976724596178806/1752612944

  String get homePageInterstitialAdUnitId =>
      "ca-app-pub-8976724596178806/1752612944";

  String get videoLeactureInterstitialAdUnit =>
      "ca-app-pub-8976724596178806/1752612944";

  String get downloadPdfInterstitialAdUnit =>
      "ca-app-pub-8976724596178806/1752612944";

  String get downloadPaperPdfInterstitialAdUnit =>
      "ca-app-pub-8976724596178806/1752612944";

// paper screen banner ad units
  String get paperSemScreenBannerAdUnit =>
      "ca-app-pub-8976724596178806/7369925229";

  String get paperPdfScreenBannerAdUnit =>
      "ca-app-pub-8976724596178806/7369925229";

// study material screen banner ad units
  String get semesterScreenBannerAdUnit =>
      "ca-app-pub-8976724596178806/7369925229";

  String get pdfScreenBannerAdUnit => "ca-app-pub-8976724596178806/7369925229";

  String get subjectScreenBannerAdUnit =>
      "ca-app-pub-8976724596178806/7369925229";

  String get branchScreenBannerAdUnit =>
      "ca-app-pub-8976724596178806/7369925229";

  final BannerAdListener adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

class AdmobHelper {
  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';
  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
    BannerAd bAd = new BannerAd(
        size: AdSize.fullBanner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: AdRequest());
    return bAd;
  }
}
