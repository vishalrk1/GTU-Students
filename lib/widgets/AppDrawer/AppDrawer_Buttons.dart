import 'package:flutter/material.dart';
import 'package:gtu_students/values/Colors.dart';

class Drawerbuttons extends StatelessWidget {
  final btnTitle;
  final Icon icon;
  final Function onPressed;

  Drawerbuttons({this.btnTitle, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed(),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 10),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 20,
            ),
            Text(
              btnTitle,
              style: TextStyle(
                color: purpleColor1,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
