import 'package:flutter/material.dart';

import '../Papers_pdf_screen.dart';

class PaperSemCard extends StatefulWidget {
  final String title;
  final String branchId;

  PaperSemCard({required this.title, required this.branchId});

  @override
  _PaperSemCardState createState() => _PaperSemCardState();
}

class _PaperSemCardState extends State<PaperSemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PapersPdfScreen.routName,
            arguments: {"branchId": widget.branchId, "semId": widget.title});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
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
      ),
    );
  }
}
