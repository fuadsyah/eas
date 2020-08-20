import 'package:cached_network_image/cached_network_image.dart';
import 'package:eas/utils/color.dart';
import 'package:eas/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/PresenceController.dart';

class PagePresence extends StatefulWidget {
  @override
  _PagePresenceState createState() => _PagePresenceState();
}

class _PagePresenceState extends PresenceController {
  @override
  Widget build(BuildContext context) {
    headerHeight = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [_header(), _presenceForm()],
      ),
    );
  }

  Widget _header() {
    return Container(
      height: headerHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: mainColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
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
                    'Selamat Datang Muhammad Fuadsyah',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'elux',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                ClipRRect(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              timeString.toString() ?? '',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'elux',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _presenceForm() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 4),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      locationFromGeolocator != null
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Lokasi Anda saat ini :\n',
                                          style: TextStyle(color: mainColor, fontFamily: 'elux', fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: locationFromGeolocator,
                                          style: TextStyle(color: mainColor, fontFamily: 'elux', fontSize: 12))
                                    ]),
                                  ),
                                  distanceToLocation != null
                                      ? Text(
                                          'Jarak anda dengan lokasi : ' + distanceToLocation + ' Meter',
                                          style: TextStyle(
                                              color: int.parse(distanceToLocation) > 1000 ? Colors.red : Colors.green,
                                              fontFamily: 'elux',
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text('Menunggu Lokasi', style: TextStyle(fontFamily: 'Nunito', color: mainColor)),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Divider(color: mainColor, thickness: 2),
                  ),
                  Container(
//                  margin: EdgeInsets.symmetric(vertical: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "Absen Masuk\n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: mainColor,
                              ),
                            ),
                            Center(
                              child: statusCheckIn == false && checkInImage == null
                                  ? CircleAvatar(
                                      backgroundColor: mainColor,
                                      radius: 63,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.white,
                                        child: new IconButton(
                                            iconSize: 60,
                                            color: mainColor,
                                            icon: Icon(
                                              Icons.camera_alt,
                                            ),
                                            onPressed: openCheckInCamera),
                                      ))
                                  : statusCheckIn == true
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            height: 130,
                                            width: 130,
                                            placeholder: (context, url) => CircularProgressIndicator(
                                              backgroundColor: mainColor,
                                            ),
//                              imageUrl: lastCheckInData["photo"] ?? "null",
                                            imageUrl: "google.com",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () => openCheckInCamera(),
                                          child: ClipOval(
                                            child: new Image.file(
                                              checkInImage,
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            new Container(
                              height: 200,
                              child: VerticalDivider(
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "Absen Keluar\n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: mainColor,
                              ),
                            ),
                            Center(
                              child: statusCheckIn == true && checkOutImage != null
                                  ? GestureDetector(
                                      onTap: () => openCheckOutCamera(),
                                      child: ClipOval(
                                        child: new Image.file(
                                          checkOutImage,
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: mainColor,
                                      radius: 63,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.white,
                                        child: new IconButton(
                                            iconSize: 60,
                                            color: mainColor,
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: openCheckOutCamera),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//                checkInImage !=null || checkOutImage !=null ?GestureDetector(
//                  onTap: () {
//                    FocusScope.of(context).unfocus();
//                  },
//                  child: Container(
//                    margin: EdgeInsets.symmetric(horizontal: 50),
//                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
//                    decoration: BoxDecoration(
//                      color: mainColor,
//                      borderRadius: BorderRadius.circular(180),
//                    ),
//                    child: Text(
//                      'Kirim',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(color: Colors.white, fontFamily: 'elux', fontSize: 16),
//                    ),
//                  ),
//                ) : SizedBox.shrink(),
                ],
              )),
        ),
      ],
    );
  }
}
