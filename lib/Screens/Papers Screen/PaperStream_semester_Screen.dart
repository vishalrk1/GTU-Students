import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:provider/provider.dart';

import 'Widgets/Paper_SemesterCard.dart';

class PapersSemScreen extends StatefulWidget {
  static const routName = '/paperSemester-name';

  @override
  _PapersSemScreenState createState() => _PapersSemScreenState();
}

class _PapersSemScreenState extends State<PapersSemScreen> {
  late List _Semesters = [];
  var _loading = true;
  late List<Object> _paperSemAdList = [];
  BannerAd? paperSemAd;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final _args = ModalRoute.of(context)!.settings.arguments;
      final docId = _args as String;
      getPapersSem(docId);
    });
  }

  getPapersSem(String id) async {
    await FirebaseFirestore.instance
        .collection("papers")
        .doc(id)
        .collection("semesters")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        _Semesters.add(doc.id);
      });
    });

    _paperSemAdList = List.from(_Semesters);

    for (int i = 1; i <= 1; i++) {
      var min = 1;
      var rm = new Random();

      var randomNumber = min + rm.nextInt(6);

      _paperSemAdList.insert(randomNumber, paperSemAd!..load());
    }

    setState(() {
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
        paperSemAd = BannerAd(
          adUnitId: adState1.paperSemScreenBannerAdUnit,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState1.adListener,
        );
      });
    });
  }

  @override
  void dispose() {
    paperSemAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    final _branchId = _args as String;
    print(_Semesters);
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
            '${_branchId}',
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                itemCount: _paperSemAdList.length,
                itemBuilder: (ctx, index) {
                  if (_paperSemAdList[index] is String) {
                    return PaperSemCard(
                      title: _paperSemAdList[index]
                          .toString(), //_paperSemAdList[index].toString() _Semesters[index]
                      branchId: _branchId,
                    );
                  } else {
                    final Container adcontainer = Container(
                      height: 50,
                      child: AdWidget(ad: _paperSemAdList[index] as BannerAd),
                      key: UniqueKey(),
                    );
                    return adcontainer;
                  }
                }),
      ),
    );
  }
}
