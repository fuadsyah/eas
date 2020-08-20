import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Navigator> navigate(context, page) {
  return Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page));
}

Future<Navigator> replaceRemoveNavigate(context, page) {
  return Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => page), (Route route) => false);
}

Future<Navigator> replaceNavigate(context, page) {
  return Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => page));
}
