import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/StudyMaterial/Widgets/Subject_Card.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:provider/provider.dart';

class SubjectScreen extends StatefulWidget {
  static const routName = '/subject-screen';

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List subjectList = [];
  var _loading = true;
  String name = '';
  late List<Object> _subjectAdList = [];
  BannerAd? subjectAd;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final branchId = _args['branchId'].toString();
      final streamId = _args['streamId'].toString();
      final semesterId = _args['semesterId'].toString();
      getSubjects(streamId, branchId, semesterId);
    });
    super.initState();
  }

  getSubjects(
    String streamId,
    String branchId,
    String semesterId,
  ) async {
    await FirebaseFirestore.instance
        .collection("streams")
        .doc(streamId)
        .collection("subStreams")
        .doc(branchId)
        .collection("semesters")
        .doc(semesterId)
        .collection("subjects")
        .get()
        .then((QuerySnapshot snapshot) =>
            snapshot.docs.forEach((DocumentSnapshot doc) {
              subjectList.add(doc.id.toString());
            }));

    _subjectAdList = List.from(subjectList);

    for (int i = 1; i <= 1; i++) {
      var min = 1;
      var rm = new Random();

      var randomNumber = min + rm.nextInt(3);

      _subjectAdList.insert(randomNumber, subjectAd!..load());
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
        subjectAd = BannerAd(
          adUnitId: adState1.subjectScreenBannerAdUnit,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState1.adListener,
        );
      });
    });
  }

  @override
  void dispose() {
    subjectAd!.dispose();
    super.dispose();
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
          colors: [bgColor1, bgColor2, bgCOlor3, bgColor4, bgCOlor5],
        ),
      ),
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
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
                itemCount: _subjectAdList.length, //_subjectAdList.length
                itemBuilder: (ctx, index) {
                  if (_subjectAdList[index] is String) {
                    return SubjectCard(
                      // title: subjectList[index],
                      title: _subjectAdList[index].toString(),
                      semesterId: semesterId,
                      branchId: branchId,
                      streamId: streamId,
                    );
                  } else {
                    final Container adcontainer = Container(
                      height: 50,
                      child: AdWidget(ad: _subjectAdList[index] as BannerAd),
                      key: UniqueKey(),
                    );
                    return adcontainer;
                  }
                }),
      ),
    );
  }
}
