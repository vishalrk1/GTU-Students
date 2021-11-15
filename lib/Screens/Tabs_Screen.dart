import 'package:flutter/material.dart';
import 'package:gtu_students/Screens/HomePageScreen/HomePage_screen.dart';
import 'package:gtu_students/Screens/Circular_screen.dart';
import 'package:gtu_students/StudyMaterial/StudyMaterial_screen.dart';
import 'package:gtu_students/widgets/AppDrawer/AppDrawer.dart';

import 'Papers Screen/Papers_Screen.dart';

class TabsScreen extends StatefulWidget {
  static const routName = '/tabs-Screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    HomePageScreen(),
    StudyMaterialScreen(),
    PapersScreen(),
    NotificationScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          selectedItemColor: Color(0xff7030C8),
          unselectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              // ignore: deprecated_member_use
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf_outlined),
              // ignore: deprecated_member_use
              title: Text("Study Material"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded),
              // ignore: deprecated_member_use
              title: Text("Papers"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              // ignore: deprecated_member_use
              title: Text("Circular"),
            ),
          ]),
    );
  }
}
