import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:provider/provider.dart';

import '../StudyMaterial/Widgets/pdf_card.dart';
import '../ads/ads_state.dart';

class PdfScreen extends StatefulWidget {
  static const routName = '/pdf-screen';

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List UnitList = [];
  List pdfUrl = [];
  var _loading = true;
  String name = '';
  BannerAd? pdfScreenBanner;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final branchId = _args['branchId'].toString();
      final streamId = _args['streamId'].toString();
      final semesterId = _args['semesterId'].toString();
      final subject = _args['title'].toString();
      getSubjects(streamId, branchId, semesterId, subject);
    });
    super.initState();
  }

  getSubjects(String streamId, String branchId, String semesterId,
      String subject) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("streams")
        .doc(streamId)
        .collection("subStreams")
        .doc(branchId)
        .collection("semesters")
        .doc(semesterId)
        .collection("subjects")
        .doc(subject)
        .get();
    setState(() {
      UnitList = snapshot.get('unitName');
      pdfUrl = snapshot.get('pdfUrl');
      _loading = false;
    });
  }

  // field for ad.....................................................................................
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState1 = Provider.of<AdState>(context);
    adState1.initialization.then((status) {
      setState(() {
        pdfScreenBanner = BannerAd(
          adUnitId: adState1.pdfScreenBannerAdUnit,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState1.adListener,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final branchId = _args['branchId'].toString();
    final streamId = _args['streamId'].toString();
    final semesterId = _args['semesterId'].toString();
    final title = _args['title'].toString();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor1,
            bgColor2,
            bgCOlor3,
            bgColor4,
            bgCOlor5,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            title,
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
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                itemCount: UnitList.length,
                itemBuilder: (ctx, index) => PdfCard(
                  title: UnitList[index].toString(),
                  url: pdfUrl[index].toString(),
                ),
              ),
        bottomNavigationBar: pdfScreenBanner == null
            ? SizedBox(
                height: 50,
              )
            : Container(
                color: Colors.transparent,
                height: 50,
                child: AdWidget(
                  ad: pdfScreenBanner!..load(),
                ),
              ),
      ),
    );
  }
}
