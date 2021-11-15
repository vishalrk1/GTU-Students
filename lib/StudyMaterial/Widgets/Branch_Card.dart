import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtu_students/StudyMaterial/Semester_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchCard extends StatefulWidget {
  final String title;
  final String branchId;
  final String streamId;

  BranchCard(
      {required this.title, required this.branchId, required this.streamId});

  @override
  _BranchCardState createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  List<String> semestersList = [];

  @override
  void initState() {
    getSemester();
    super.initState();
  }

  getSemester() async {
    await FirebaseFirestore.instance
        .collection("streams")
        .doc(widget.streamId)
        .collection("subStreams")
        .doc(widget.branchId)
        .collection("semesters")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        semestersList.add(doc.get('title').toString());
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _expanded = false;
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(SemesterScreen.routName, arguments: {
                    'branchId': widget.branchId,
                    'streamId': widget.streamId,
                    'branchName': widget.title
                  });
                },
                child: ListTile(
                  title: Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  leading: Icon(Icons.book),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
