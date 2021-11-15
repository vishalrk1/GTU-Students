import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_students/Screens/HomePageScreen/HomePage_screen.dart';
import 'package:gtu_students/Screens/Tabs_Screen.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:gtu_students/widgets/AppDrawer/AppDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackScreen extends StatefulWidget {
  static const routName = '/feedback-page';

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final _nameFocusNode = FocusNode();
  final _feedbackFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _exit = false;
  var _isLoading = false;

  Map<String, dynamic> data = {
    'name': '',
    'feedback': '',
  };

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _feedbackFocusNode.dispose();
    super.dispose();
  }

  late CollectionReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseFirestore.instance.collection('feedback');
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    _ref.add(data).then(
      (value) {
        // Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Submited successfully'),
            content: Text("""Thank you for Your Feedback"""),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routName);
                  },
                  child: Text('Okay'))
            ],
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

// url launcher lol.......................................................................................................
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              //title: Text('ONIKIRI',style: TextStyle(color: Colors.white),),
              backgroundColor: Theme.of(context).primaryColorLight,
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20, right: 5, left: 10, bottom: 5),
                    child: Text(
                        """Give your valuable feedBack so that we can improve our app""",
                        style: GoogleFonts.play(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  // text fields........................................................................................................
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Submit FeedBack',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // first text field.......................................................................................................
                          TextFormField(
                            style: GoogleFonts.play(color: Colors.white),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelStyle:
                                    GoogleFonts.play(color: Colors.white),
                                labelText: 'Name',
                                fillColor: Colors.white),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_nameFocusNode);
                            },
                            onSaved: (value) {
                              data['name'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Entre Something';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Second text field.......................................................................................................
                          TextFormField(
                            style: GoogleFonts.play(color: Colors.white),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.play(color: Colors.white),
                              labelText: 'FeedBack',
                            ),
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_feedbackFocusNode);
                            },
                            onSaved: (value) {
                              data['feedback'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Entre Something';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 50),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              color: Colors.amber[200],
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40),
                              onPressed: () {
                                // Navigator.of(context).pop();
                                _saveForm();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
