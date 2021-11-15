import 'package:flutter/material.dart';
import 'package:gtu_students/Screens/AboutScreen/About_Screen.dart';
import 'package:gtu_students/Screens/ContactScreen/Contact_Screen.dart';
import 'package:gtu_students/Screens/FeedBack_Screen.dart';
import 'package:gtu_students/Screens/Tabs_Screen.dart';
import 'package:gtu_students/widgets/AppDrawer/AppDrawer_Buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
    return Drawer(
      child: ListView(
        children: <Widget>[
// Header of Drawer with GTU Logo................................
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff501890),
                  Color(0xff6020A8),
                  Color(0xff7028C0),
                  Color(0xff8070D8),
                ],
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                padding: EdgeInsets.all(20),
                child: ClipOval(
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
// home button.........................................................
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
// share Button................................................
          InkWell(
            onTap: () {
              _launchInBrowser(
                  "https://play.google.com/store/apps/developer?id=EngineeringVala");
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.share),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Our Apps',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.share),
          //     title: Text(
          //       'Our Apps',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColorDark,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onTap: () {
          //       _launchInBrowser(
          //           "https://play.google.com/store/apps/developer?id=EngineeringVala");
          //     },
          //   ),
          // ),
          // Divider(),
// Rate Us..................................................
          InkWell(
            onTap: () {
              _launchInBrowser(
                  'https://play.google.com/store/apps/details?id=com.hemang833.GTU_Student');
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Rate US',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.star),
          //     title: Text(
          //       'Rate Us',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColorDark,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onTap: () {
          //       _launchInBrowser(
          //           'https://play.google.com/store/apps/details?id=com.hemang833.GTU_Student');
          //     },
          //   ),
          // ),
          // Divider(),
// feedback button...................................................................................................
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(FeedBackScreen.routName);
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.message),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'FeedBack',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.star),
          //     title: Text(
          //       'FeedBack',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColorDark,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.of(context)
          //           .pushReplacementNamed(FeedBackScreen.routName);
          //     },
          //   ),
          // ),
          // Divider(),
// About us button...........................................
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AboutUsScreen.routName);
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_box),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'About Us',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.account_box),
          //     title: Text(
          //       'About Us',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColorDark,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onTap: () {},
          //   ),
          // ),
          // Divider(),
// About us button...........................................
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ContactScreen.routName);
            },
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Color(0xff7030C8),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.phone),
          //     title: Text(
          //       'Contact Us',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColorDark,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onTap: () {},
          //   ),
          // ),
          // Divider(),
        ],
      ),
    );
  }
}
