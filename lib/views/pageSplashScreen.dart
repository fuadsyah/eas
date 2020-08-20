import 'package:eas/utils/utils.dart';
import 'package:eas/views/pageLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSplashScreen extends StatefulWidget {
  @override
  _PageSplashScreenState createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () => replaceNavigate(context, PageLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/logo/elux.png'),
          image: AssetImage('assets/logo/elux2.png'),
          width: 100,
          fadeInDuration: Duration(seconds: 1),
          fadeOutDuration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
