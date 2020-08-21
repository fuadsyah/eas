import 'dart:io';

import 'package:eas/utils/utils.dart';
import 'package:eas/views/pageService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageOnSpot extends StatefulWidget {
  @override
  _PageOnSpotState createState() => _PageOnSpotState();
}

class _PageOnSpotState extends State<PageOnSpot> {
  TextEditingController person = TextEditingController();
  TextEditingController info = TextEditingController();

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
        _confirmationForm(),
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
                    'Konfirmasi Kedatangan',
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

  Widget _confirmationForm() {
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
              scrollDirection: Axis.vertical,
              children: [
                ///confirmation banner
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.my_location, color: mainColor),
                      SizedBox(width: 20,),
                      Expanded(
                          child: Text(
                        'Lakukan konfirmasi bahwa anda sudah di lokasi pelanggan',
                        style: TextStyle(fontFamily: 'elux', color: Colors.white),
                      )),
                    ],
                  ),
                ),
                ///person textField
                TextField(
                  maxLines: null,
                  controller: person,
                  style: TextStyle(fontFamily: 'elux'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Bertemu dengan',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                ///info textField
                TextField(
                  maxLines: null,
                  controller: info,
                  style: TextStyle(fontFamily: 'elux'),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                      labelText: 'Keterangan (tidak wajib)',
                      labelStyle: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                ///take photo
                GestureDetector(
                  onTap: () => openCamera(),
                  child: Container(
                    height: 300,
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
              ],
            ),
          ),
        ),
        ///submit button
        FlatButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            replaceRemoveNavigate(context, PageService());
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20,),
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
