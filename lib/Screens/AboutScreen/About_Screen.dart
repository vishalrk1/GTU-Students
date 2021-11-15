import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_students/helpers/Url_Launcher.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../policy%20and%20terms/Private_Policy.dart';
import '../../policy%20and%20terms/Terms_Condition.dart';

class AboutUsScreen extends StatefulWidget {
  static const routName = '/aboutUs-page';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
                    padding: EdgeInsets.only(top: 25, right: 10, left: 10),
                    child: Text(
                      "WE AS A DEVELOPER, DO NOT CLAIM ANY RIGHTS ON ANY OF THE CONTANT PROVIDED IN THIS APP",
                      style: GoogleFonts.play(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(top: 35, right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "1]  ALL THE RESULT, TIMETABLE,PAPERS, SYLLABUS, CIRCULARS  IS PROVIDED BY GUJARAT TECHENICAL UNIVERSITY",
                          style: GoogleFonts.play(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            UrlLauncher()
                                .launchInBrowser("https://www.gtu.ac.in/");
                          },
                          child: Text(
                            "GTU WEBSITE",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.yellow[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "2]  ALL THE STUDY MATERIALS IN THIS APP IS PROVIDED BY DARSHAN UNIVERSITY",
                          style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            UrlLauncher()
                                .launchInBrowser("https://www.darshan.ac.in/");
                          },
                          child: Text(
                            "DARSHAN UNIVERSITY",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.yellow[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text("Privacy Poilcy"),
                        subtitle: Text("Read Our policy here"),
                        // ignore: deprecated_member_use
                        trailing: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PolicyScreen.routName);
                          },
                          child: Text(
                            "Read Policy",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ListTile(
                          title: Text("Terms & Conditions"),
                          subtitle: Text("Read Our Terms & Conditions"),
                          // ignore: deprecated_member_use
                          trailing: RaisedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(TermsConditionScreen.routName);
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
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
