import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:provider/provider.dart';

import 'Widgets/paper_pdf_card.dart';

class PapersPdfScreen extends StatefulWidget {
  static const routName = '/paperPdf-name';

  @override
  _PapersPdfScreenState createState() => _PapersPdfScreenState();
}

class _PapersPdfScreenState extends State<PapersPdfScreen> {
  List _pdfUrl = [];
  List _paperName = [];
  var _loading = true;
  BannerAd? paperPdfBanner;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final branchId = _args['branchId'].toString();
      final semId = _args['semId'].toString();
      getPapersSem(branchId, semId);
    });
  }

  getPapersSem(String branchId, String semId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("papers")
        .doc(branchId)
        .collection("semesters")
        .doc(semId)
        .get();
    setState(() {
      _pdfUrl = snapshot.get('pdfUrl');
      _paperName = snapshot.get('paperName');
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
        paperPdfBanner = BannerAd(
          adUnitId: adState1.paperPdfScreenBannerAdUnit,
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
    final semName = _args['semId'].toString();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff8070D8),
            Color(0Xff8070E0),
            Color(0xff8888F0),
            Color(0xff8098F0),
            Color(0xff90B0F0),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            '${semName}',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                itemCount: _pdfUrl.length,
                itemBuilder: (ctx, index) => PaperPdfCard(
                  title: _paperName[index],
                  url: _pdfUrl[index],
                ),
              ),
        bottomNavigationBar: paperPdfBanner == null
            ? SizedBox(
                height: 50,
              )
            : Container(
                color: Colors.transparent,
                height: 50,
                child: AdWidget(
                  ad: paperPdfBanner!..load(),
                ),
              ),
      ),
    );
  }
}
