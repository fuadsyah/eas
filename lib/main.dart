import 'package:eas/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/pageSplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ///disable automatic ui adjustment for navBar and notificationBar
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;

    ///only potrait orientation use
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ///set overlay style of NavBar and StatusBar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
//        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: mainColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );


    return MaterialApp(
      title: 'Electrolux Authorized Service (EAS)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageSplashScreen(),
    );
  }
}

