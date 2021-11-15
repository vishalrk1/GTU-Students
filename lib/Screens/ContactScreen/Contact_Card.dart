import 'package:flutter/material.dart';
import 'package:gtu_students/helpers/Url_Launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.link,
    required this.imgPath,
    required this.subTitle,
    required this.title,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String imgPath;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            UrlLauncher().launchInBrowser(link);
          },
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(subTitle),
            leading: CircleAvatar(
              child: Image.asset(imgPath),
            ),
          ),
        ),
      ),
    );
  }
}
