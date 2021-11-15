import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gtu_students/Services/local_notification_services.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:gtu_students/widgets/AppDrawer/AppDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  static const routName = '/notification-screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List circulrMessage = [];
  List circularTitle = [];
  List<Timestamp> circularDate = [];
  var _loading = true;
  var _exit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCircularMEssage();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        print(message.notification!.title);
        print(message.sentTime);
        print(message.notification!.body);
        // final routeFromMessage = message.data["route"];
        // Navigator.of(context).pushNamed(NotificationScreen.routName);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message != null) {
        print(message.notification!.title);
        print(message.sentTime);
        print(message.notification!.body);
      } else {
        print("got a null message");
      }
      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Notifications Are Working"),
                ));
      },
    );
  }

  getCircularMEssage() async {
    await FirebaseFirestore.instance
        .collection("circular")
        .orderBy('Date', descending: true)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        circularTitle.add(doc.get('title'));
        circulrMessage.add(doc.get('Message'));
        circularDate.add(doc.get('Date'));
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
          // backgroundColor: Colors.blue[100],
          body: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: circularTitle.length,
                  itemBuilder: (ctx, index) {
                    DateTime date = circularDate[index].toDate();
                    return NotificationCard(
                      title: circularTitle[index],
                      message: circulrMessage[index],
                      time: date,
                    );
                  },
                ),
          // NotificationCard(
          //   title: 'Welcome to Gtu Students App',
          //   message:
          //       "",
          //   time: DateTime.now(),
          // ).
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final DateTime time;

  NotificationCard(
      {required this.title, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      elevation: 3,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 25, right: 25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "${time.day}-${time.month}-${time.year}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
