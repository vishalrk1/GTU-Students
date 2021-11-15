import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/helpers/Url_Launcher.dart';
import 'package:gtu_students/values/Colors.dart';
import 'package:provider/provider.dart';

import '../../widgets/AppDrawer/AppDrawer.dart';
import 'widget/category_item.dart';

class HomePageScreen extends StatefulWidget {
  static const routName = '/home-page';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool _exit = false;

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  Future<void> getCategories() async {
    await Provider.of<DataProvider>(context, listen: false).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Container(
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
        body: WillPopScope(
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
                            UrlLauncher().launchInBrowser(
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
          child: dataProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  itemCount: dataProvider.homeCategoryList.length,
                  itemBuilder: (ctx, index) => CategoryItem(
                    title: dataProvider.homeCategoryList[index].title,
                    imgLink: dataProvider.homeCategoryList[index].imgLink,
                    webLink: dataProvider.homeCategoryList[index].webLink,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 330,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
