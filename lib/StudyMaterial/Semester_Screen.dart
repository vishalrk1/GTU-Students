import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:provider/provider.dart';

import '../StudyMaterial/Widgets/Semester_card.dart';

class SemesterScreen extends StatefulWidget {
  static const routName = '/semester-screen';

  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  List<String> semestersList = [];
  List<String> semIdList = [];
  late List<Object> _semAdList = [];
  BannerAd? semAd;
  var _loading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final branchId = _args['branchId'].toString();
      final streamId = _args['streamId'].toString();
      getSemester(streamId, branchId);
    });
    super.initState();
  }

  getSemester(
    String streamId,
    String branchId,
  ) async {
    await FirebaseFirestore.instance
        .collection("streams")
        .doc(streamId)
        .collection("subStreams")
        .doc(branchId)
        .collection("semesters")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        semestersList.add(
          doc.get('title').toString(),
        );
        semIdList.add(doc.id.toString());
      });
    });

    _semAdList = List.from(semestersList);

    for (int i = 1; i <= 1; i++) {
      var min = 1;
      var rm = new Random();

      var randomNumber = min + rm.nextInt(6);

      _semAdList.insert(randomNumber, semAd!..load());
      semIdList.insert(randomNumber, "ad Index");
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
        semAd = BannerAd(
          adUnitId: adState1.semesterScreenBannerAdUnit,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState1.adListener,
        );
      });
    });
  }

  @override
  void dispose() {
    semAd!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final _branchName = _args['branchName'].toString();
    final _streamId = _args['streamId'].toString();
    final _branchId = _args['branchId'].toString();

    print(semestersList);
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
            _branchName,
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
                ),
                itemCount: _semAdList.length,
                itemBuilder: (ctx, index) {
                  if (_semAdList[index] is String) {
                    return SemesterCard(
                      title: _semAdList[index]
                          .toString(), //_semAdList[index].toString() semestersList[index]
                      semesterId: semIdList[index],
                      branchId: _branchId,
                      streamId: _streamId,
                    );
                  } else {
                    final Container adcontainer = Container(
                      height: 50,
                      child: AdWidget(ad: _semAdList[index] as BannerAd),
                      key: UniqueKey(),
                    );
                    return adcontainer;
                  }
                }),
      ),
    );
  }
}
