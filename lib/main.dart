import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtu_students/DataProvider/DataProvider.dart';
import 'package:gtu_students/WebView/WebView.dart';
import 'package:provider/provider.dart';

import 'Screens/AboutScreen/About_Screen.dart';
import 'Screens/Circular_screen.dart';
import 'Screens/ContactScreen/Contact_Screen.dart';
import 'Screens/FeedBack_Screen.dart';
import 'Screens/HomePageScreen/HomePage_screen.dart';
import 'Screens/Papers Screen/PaperStream_semester_Screen.dart';
import 'Screens/Papers Screen/Papers_Screen.dart';
import 'Screens/Papers Screen/Papers_pdf_screen.dart';
import 'Screens/Tabs_Screen.dart';
import 'StudyMaterial/Branch_Screen.dart';
import 'StudyMaterial/Semester_Screen.dart';
import 'StudyMaterial/Subject_Screen.dart';
import 'StudyMaterial/pdf_Screen.dart';
import 'ads/ads_state.dart';
import 'policy and terms/Private_Policy.dart';
import 'policy and terms/Terms_Condition.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
// firebase initilization.........................................................
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// fluttr downloader initilization.................................................
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
// auto rotation off ..............................................................
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
// add plugin inilitization.............................................................................
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          canvasColor: Colors.white,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1), //
                ),
                // ignore: deprecated_member_use
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                // ignore: deprecated_member_use
                subtitle1: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        home: TabsScreen(),
        routes: {
          HomePageScreen.routName: (ctx) => HomePageScreen(),
          TabsScreen.routName: (ctx) => TabsScreen(),
          FeedBackScreen.routName: (ctx) => FeedBackScreen(),
          NotificationScreen.routName: (ctx) => NotificationScreen(),
          StreamScreen.routName: (ctx) => StreamScreen(),
          SemesterScreen.routName: (ctx) => SemesterScreen(),
          SubjectScreen.routName: (ctx) => SubjectScreen(),
          PdfScreen.routName: (ctx) => PdfScreen(),
          PapersScreen.routName: (ctx) => PapersScreen(),
          PapersSemScreen.routName: (ctx) => PapersSemScreen(),
          PapersPdfScreen.routName: (ctx) => PapersPdfScreen(),
          AboutUsScreen.routName: (ctx) => AboutUsScreen(),
          ContactScreen.routName: (ctx) => ContactScreen(),
          PolicyScreen.routName: (ctx) => PolicyScreen(),
          TermsConditionScreen.routName: (ctx) => TermsConditionScreen(),
          WebViewScreen.routName: (ctx) => WebViewScreen(),
        },
      ),
    );
  }
}
