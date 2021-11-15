import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/StudyMaterial/pdf_Screen.dart';
import 'package:provider/provider.dart';

class SubjectCard extends StatefulWidget {
  final String title;
  final String streamId;
  final String branchId;
  final String semesterId;

  SubjectCard(
      {required this.title,
      required this.semesterId,
      required this.branchId,
      required this.streamId});

  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  Future<void> getPfdData(String streamId, String branchId, String semesterId,
      String subject) async {
    await Provider.of<DataProvider>(context, listen: false).getPdfData(
      streamId: streamId,
      branchId: branchId,
      semesterId: semesterId,
      subject: subject,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getPfdData(
            widget.streamId, widget.branchId, widget.semesterId, widget.title);
        Navigator.of(context).pushNamed(PdfScreen.routName, arguments: {
          'streamId': widget.streamId,
          'branchId': widget.branchId,
          'semesterId': widget.semesterId,
          'title': widget.title,
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Card(
          elevation: 5,
          color: Colors.grey[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
