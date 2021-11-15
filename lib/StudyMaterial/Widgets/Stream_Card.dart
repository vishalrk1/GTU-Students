import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gtu_students/StudyMaterial/Branch_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamCard extends StatefulWidget {
  final String title;
  final String id;

  StreamCard({
    required this.title,
    required this.id,
  });

  @override
  _StreamCardState createState() => _StreamCardState();
}

class _StreamCardState extends State<StreamCard> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.white,
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(StreamScreen.routName,
              arguments: {"id": widget.id, "stream": widget.title});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.arrow_forward_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
