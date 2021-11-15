import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/Screens/Tabs_Screen.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const routName = '/web-screen';
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

//  ad loader..................................
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then(
      (value) {
        InterstitialAd.load(
          adUnitId: adState.homePageInterstitialAdUnitId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              this._interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error');
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context)!.settings.arguments as String;
    return WillPopScope(
      onWillPop: () async {
        _interstitialAd.show();
        Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
        return true;
      },
      child: WebviewScaffold(
        appBar: AppBar(
          title: const Text(
            'GTU Students',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff501890),
                  Color(0xff6020A8),
                  Color(0xff7028C0),
                ],
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                _interstitialAd.show();
                Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        url: url,
        clearCache: true,
        scrollBar: true,
        withZoom: true,
        initialChild: Center(
          child: CircularProgressIndicator(
            color: Colors.amber[200],
          ),
        ),
      ),
    );
  }
}
