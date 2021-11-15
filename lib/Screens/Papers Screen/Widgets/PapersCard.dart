import 'dart:ui';

import 'package:flutter/material.dart';
import '../PaperStream_semester_Screen.dart';

class PaperCard extends StatefulWidget {
  final String title;

  PaperCard({
    required this.title,
  });

  @override
  _PaperCardState createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PapersSemScreen.routName, arguments: widget.title);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                title: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
