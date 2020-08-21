import 'dart:ui';

import 'package:eas/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageCalculateCost extends StatefulWidget {
  @override
  _PageCalculateCost createState() => _PageCalculateCost();
}

class _PageCalculateCost extends State<PageCalculateCost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _header(),
        _calculateForm(),
      ],
    );
  }

  Widget _header() {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: mainColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Hitung estimasi biaya',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'elux',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calculateForm() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 7),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                TextField(
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Dropdown',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                TextField(
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Dropdown',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                TextField(
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Dropdown',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                TextField(
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Dropdown',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                TextField(
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Dropdown',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
              ],
            ),
          ),
        ),
        _calculateButton(),
      ],
    );
  }

  Widget _calculateButton() {
    return FlatButton(
      onPressed: () => _onCalculateCost(),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(180),
        ),
        child: Center(
          child: Text(
            'Jumlahkan',
            style: TextStyle(color: Colors.white, fontFamily: 'elux', fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _onCalculateCost() {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                child: Text('Kembali', style: TextStyle(fontFamily: 'elux', color: mainColor, fontSize: 13)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            content: Column(
              children: [
                Center(child: Text('Estimasi biaya perbaikan', style: TextStyle(fontFamily: 'elux'))),
                SizedBox(height: 30),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Text('Jasa X : Rp.XXXXXXX'),
                SizedBox(height: 10),
                Divider(color: mainColor, height: 20, thickness: 1),
                Text('Total estimasi perbaikan : RP.XXXXXXX'),
              ],
            ),
          );
        });
  }
}
