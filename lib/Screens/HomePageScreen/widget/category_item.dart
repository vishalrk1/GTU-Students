import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/WebView/WebView.dart';
import 'package:gtu_students/helpers/Url_Launcher.dart';

class CategoryItem extends StatefulWidget {
  final String title;
  final String imgLink;
  final String webLink;

  CategoryItem(
      {required this.title, required this.imgLink, required this.webLink});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  // late InterstitialAd _interstitialAd;

// ad loader..................................
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final adState = Provider.of<AdState>(context);
  //   adState.initialization.then(
  //     (value) {
  //       InterstitialAd.load(
  //         adUnitId: adState.homePageInterstitialAdUnitId,
  //         request: AdRequest(),
  //         adLoadCallback: InterstitialAdLoadCallback(
  //           onAdLoaded: (InterstitialAd ad) {
  //             // Keep a reference to the ad so you can show it later.
  //             this._interstitialAd = ad;
  //           },
  //           onAdFailedToLoad: (LoadAdError error) {
  //             print('InterstitialAd failed to load: $error');
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(WebViewScreen.routName, arguments: widget.webLink);
        // UrlLauncher().launchInBrowser(widget.webLink);
        // _interstitialAd.show();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.only(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.network(
                  widget.imgLink,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 2, right: 2),
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
