import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/helpers/Url_Launcher.dart';
import 'package:gtu_students/values/Colors.dart';

import 'package:provider/provider.dart';

import '../StudyMaterial/Widgets/Stream_Card.dart';
import '../StudyMaterial/Widgets/Video_Tile.dart';
import '../widgets/AppDrawer/AppDrawer.dart';

class StudyMaterialScreen extends StatefulWidget {
  @override
  _StudyMaterialScreenState createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends State<StudyMaterialScreen> {
  var _exit = false;

  List streamTitleList = [];
  List streamId = [];
  var _isstreamLoading = true;

  @override
  void initState() {
    getVideoLeacture();
    getStreams();
    super.initState();
  }

  getVideoLeacture() async {
    await Provider.of<DataProvider>(context, listen: false)
        .getLecturChannelData();
  }

  getStreams() async {
    await Provider.of<DataProvider>(context, listen: false).getStreamData();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    """GTU Student """,
                  ),
                  content: Text(
                      """GTU Student is a free application made with love, but we're working too much to provide this service for free


Please give us 5 stars to support our work"""),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _exit = true;
                        });
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else {
                          exit(0);
                        }
                      },
                      child: Text(
                        "NO THANKS :(",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        UrlLauncher().launchInBrowser(
                            'https://play.google.com/store/apps/details?id=com.hemang833.GTU_Student');
                      },
                      child: Text(
                        "OF COURSE",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ));
        if (_exit) {
          return true;
        } else {
          return false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgColor1, bgColor2, bgCOlor3, bgColor4, bgCOlor5],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
          ),
          drawer: AppDrawer(),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Video Leactures',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 130,
                child: Center(
                  child: dataProvider.isLoading
                      ? CircularProgressIndicator(
                          color: Colors.yellow,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.channelList.length,
                          itemBuilder: (ctx, index) {
                            return VideoTile(
                              name: dataProvider.channelList[index].chName,
                              image:
                                  dataProvider.channelList[index].profileImage,
                              url: dataProvider.channelList[index].ytlink,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Free Material',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 400,
                child: Center(
                  child: dataProvider.isLoading
                      ? CircularProgressIndicator(
                          color: Colors.yellow,
                        )
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          itemCount: dataProvider
                              .streamsList.length, //streamTitleList.length
                          itemBuilder: (ctx, index) {
                            return StreamCard(
                              title: dataProvider.streamsList[index].streamName,
                              id: dataProvider.streamsList[index].id,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
