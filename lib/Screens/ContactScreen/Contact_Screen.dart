import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_students/Screens/ContactScreen/Contact_Card.dart';
import 'package:gtu_students/values/Colors.dart';

class ContactScreen extends StatefulWidget {
  static const routName = '/contactUs-page';

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
                    padding: EdgeInsets.only(
                      top: 25,
                      right: 10,
                      left: 15,
                    ),
                    child: Text(
                      "Social Media",
                      style: GoogleFonts.play(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 5, left: 5),
                    child: Column(
                      children: <Widget>[
                        ContactCard(
                          link:
                              "https://www.instagram.com/gtumedia/?utm_medium=copy_link",
                          imgPath: 'assets/instagram.png',
                          subTitle: "Follow our instagram for future updates",
                          title: 'Instagram',
                        ),
                        ContactCard(
                          link: "https://twitter.com/GTUoffice?s=09",
                          imgPath: 'assets/Twitter.jpg',
                          subTitle: "Follow our twitter for future updates",
                          title: 'Twitter',
                        ),
                        ContactCard(
                          link:
                              "https://www.youtube.com/c/GujaratTechnologicalUniversity/videos",
                          imgPath: 'assets/YouTube.png',
                          subTitle: "Subscribe our Youtube channel",
                          title: 'YouTube',
                        ),
                      ],
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
