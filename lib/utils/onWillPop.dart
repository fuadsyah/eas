import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'color.dart';

DateTime currentBackPressTime;

Future<bool> onWillPop() async{
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
      backgroundColor: Colors.grey.shade200,
      msg: "Tekan sekali lagi untuk keluar",
      textColor: mainColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
    return Future.value(false);
  }
  return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//  MoveToBackground.moveTaskToBack();
//  return false;

}