import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PdfCard extends StatefulWidget {
  final String title;
  final String url;

  PdfCard({required this.title, required this.url});

  @override
  _PdfCardState createState() => _PdfCardState();
}

class _PdfCardState extends State<PdfCard> {
  var _downloading = false;
  final Dio dio = Dio();
  double progress = 0;
  InterstitialAd? _interstitialAd;

  Future<Directory?> downloadsDirectory =
      DownloadsPathProvider.downloadsDirectory;

  final errorSnackBar = SnackBar(
    content: Text('Download Failed!!.. Please restart and try again'),
  );

  final downloadSuccessfullSnackBar = SnackBar(
    content: Text('Download SucessFull!!... Check your downloades'),
  );

  Future<bool> savePdf(String url, String fileName) async {
    if (await _requestPermission(Permission.storage)) {
      Directory? directory;
      directory = await DownloadsPathProvider.downloadsDirectory;
      File saveFile = File(directory!.path + "/$fileName");
      print(saveFile.path);
      await startDownload(saveFile.path, url);
      return true;
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile(String fileUrl, String fileName) async {
    setState(() {
      _downloading = true;
      progress = 0;
    });
    bool downloaded = await savePdf(
      fileUrl,
      fileName,
    );
    if (downloaded) {
      print("File Downloaded");
      ScaffoldMessenger.of(context).showSnackBar(downloadSuccessfullSnackBar);
    } else {
      print("Problem Downloading File");
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future startDownload(String savePath, String urlPath) async {
    Map<String, dynamic> result = {
      "isSuccess": false,
      "filePath": null,
      "error": null
    };
    try {
      var response = await dio.download(urlPath, savePath);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      setState(() {
        _downloading = false;
      });
      _showNotification(result);
      _interstitialAd!.show();
    }
  }

  Future _showNotification(Map<String, dynamic> downloadStatus) async {
    final andorid = AndroidNotificationDetails(
        "channelId", 'GTU Students', 'channelDescription',
        priority: Priority.high, importance: Importance.max);
    final ios = IOSNotificationDetails();
    final notificationDetails = NotificationDetails(android: andorid, iOS: ios);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];
    await FlutterLocalNotificationsPlugin().show(
        0,
        isSuccess ? "Sucess" : "error",
        isSuccess ? "File Download Successful " : "File Download Faild",
        notificationDetails,
        payload: json);
  }

  Future<dynamic> _onselectedNotification(String? json) async {
    final obj = jsonDecode(json!);
    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(obj['error']),
              ));
    }
  }

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final initSetting = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: _onselectedNotification);
  }

// ad loader.....................................................................................
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then(
      (value) {
        InterstitialAd.load(
          adUnitId: adState.downloadPdfInterstitialAdUnit,
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
  void dispose() {
    _interstitialAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        // margin: EdgeInsets.only(top: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              widget.title,
              style:
                  GoogleFonts.play(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            subtitle: _downloading
                ? Text(
                    "Downloading...",
                    style: GoogleFonts.play(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  )
                : null,
            trailing: _downloading
                ? Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.yellow,
                    ),
                  )
                // ignore: deprecated_member_use
                : RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                    child: Text(
                      'Download PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      downloadFile(widget.url, "${widget.title}.pdf");
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
