import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/ads/ads_state.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:provider/provider.dart';

import 'Widgets/Branch_Card.dart';

class StreamScreen extends StatefulWidget {
  static const routName = '/stream-screen';

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  List<String> branchNameList = [];
  List<String> branchIdList = [];
  late List _branchAdList = [];
  BannerAd? branchAd;
  var loading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final streamId = _args['id'].toString();
      getbranchs(streamId);
    });
    super.initState();
  }

  getbranchs(String streamId) async {
    await Provider.of<DataProvider>(context, listen: false)
        .getBranchData(streamId: streamId);

    addAdvertice();
    _branchAdList = [];

    for (int i = 1; i <= 1; i++) {
      var min = 1;
      var rm = new Random();

      var randomNumber = min + rm.nextInt(6);

      _branchAdList.insert(randomNumber, branchAd!..load());
      branchIdList.insert(randomNumber, "ad Index");
    }
    setState(() {
      loading = false;
    });
  }

  addAdvertice() {
    Provider.of<DataProvider>(context, listen: false)
        .branchList
        .forEach((branch) {
      branchNameList.add(branch.branchName);
      branchIdList.add(branch.id);
    });

    _branchAdList = branchNameList;

    for (int i = 1; i <= 1; i++) {
      var min = 1;
      var rm = new Random();

      var randomNumber = min + rm.nextInt(6);

      _branchAdList.insert(randomNumber, branchAd!..load());
      branchIdList.insert(randomNumber, "ad Index");
    }
    setState(() {
      loading = false;
    });
  }

// field for ad.....................................................................................
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState1 = Provider.of<AdState>(context);
    adState1.initialization.then((status) {
      setState(() {
        branchAd = BannerAd(
          adUnitId: adState1.branchScreenBannerAdUnit,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState1.adListener,
        );
      });
    });
  }

  @override
  void dispose() {
    branchAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final streamId = _args['id'].toString();
    final title = _args['stream'].toString();
    final dataProvider = Provider.of<DataProvider>(context);
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
        body: ListView.builder(
          itemCount: _branchAdList.length,
          itemBuilder: (ctx, index) {
            if (_branchAdList[index] is String) {
              return BranchCard(
                title: _branchAdList[index],
                branchId: branchIdList[index],
                streamId: streamId,
              );
            } else {
              final Container adcontainer = Container(
                height: 50,
                child: AdWidget(ad: _branchAdList[index] as BannerAd),
                key: UniqueKey(),
              );
              return adcontainer;
            }
          },
        ),
      ),
    );
  }
}
