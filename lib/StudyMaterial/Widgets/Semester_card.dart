import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_students/StudyMaterial/Subject_Screen.dart';

class SemesterCard extends StatefulWidget {
  final String title;
  final String streamId;
  final String branchId;
  final String semesterId;

  SemesterCard(
      {required this.title,
      required this.semesterId,
      required this.branchId,
      required this.streamId});

  @override
  _SemesterCardState createState() => _SemesterCardState();
}

class _SemesterCardState extends State<SemesterCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(SubjectScreen.routName, arguments: {
          'streamId': widget.streamId,
          'branchId': widget.branchId,
          'semesterId': widget.semesterId,
          'title': widget.title,
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          color: Colors.grey[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
