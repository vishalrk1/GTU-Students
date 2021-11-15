import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtu_students/widgets/AppDrawer/AppDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Widgets/PapersCard.dart';

class PapersScreen extends StatefulWidget {
  static const routName = '/papers-name';

  @override
  _PapersScreenState createState() => _PapersScreenState();
}

class _PapersScreenState extends State<PapersScreen> {
  List _branchNames = [];
  var _loading = true;
  var _exit = false;

  @override
  void initState() {
    super.initState();
    getPapers();
  }

  getPapers() async {
    await FirebaseFirestore.instance
        .collection("papers")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        _branchNames.add(doc.id);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_branchNames);
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
                        _launchInBrowser(
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
          body: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  itemCount: _branchNames.length,
                  itemBuilder: (ctx, index) => PaperCard(
                    title: _branchNames[index],
                  ),
                ),
        ),
      ),
    );
  }
}
