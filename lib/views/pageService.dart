import 'dart:io';
import 'package:eas/utils/utils.dart';
import 'package:eas/views/pageHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'pageCalculateCost.dart';

class PageService extends StatefulWidget {
  @override
  _PageServiceState createState() => _PageServiceState();
}

class _PageServiceState extends State<PageService> {
  File attachment;

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
        _serviceForm(),
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
                    'Informasi Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'elux',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () => navigate(context, PageCalculateCost()), child: Icon(Icons.table_chart, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceForm() {
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
                      labelText: 'Keterangan',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                GestureDetector(
                  onTap: () => openCamera(),
                  child: Container(
                    height: 250,
                    child: attachment == null
                        ? Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: mainColor,
                              size: 50,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(attachment, fit: BoxFit.cover),
                            ),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    replaceRemoveNavigate(context, PageHome());
                  },
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
                        'Simpan',
                        style: TextStyle(color: Colors.white, fontFamily: 'elux', fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future openCamera() async {
    var imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    await compressImage(File(imageFile.path)).then((image) {
      setState(() {
        attachment = image;
      });
    });
  }
}
