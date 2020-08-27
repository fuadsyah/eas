import 'package:eas/utils/color.dart';
import 'package:eas/utils/navigator.dart';
import 'package:eas/views/pageOnSpot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:trust_location/trust_location.dart';

class PageOnDuty extends StatefulWidget{

  @override
  _PageOnDutyState createState()=> _PageOnDutyState();
}

class _PageOnDutyState extends State<PageOnDuty>{
  String longitude;
  String latitude;


  @override
  void initState(){
    super.initState();

    TrustLocation.start(5);

    getLocation();
  }


  /// get location method, use a try/catch PlatformException.
  Future<void> getLocation() async {
    Future.delayed(Duration(seconds: 10), (){
      try {
        TrustLocation.onChange.listen((values) {
          if (mounted) {
            setState(() {
              latitude = values.latitude;
              longitude = values.longitude;

            });
          }
        });
      } on PlatformException catch (e) {
        print('PlatformException $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body(){
    return WillPopScope(
      onWillPop: ()async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 50
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Lottie.asset('assets/lottie/otw.json', width: 250))),
            Text('Interval waktu pengambilan lokasi per 10detik'),
            Text('latitude :'+latitude.toString()),
            Text('longitude :'+longitude.toString()),
            SizedBox(height: 20),
            ConfirmationSlider(
              shadow: BoxShadow(
                  color: Colors.transparent
              ),
              backgroundColor: mainColor,
              height: 60,
              text: 'Saya sudah sampai',
              foregroundColor: Colors.white,
              iconColor: mainColor,
              textStyle: TextStyle(fontFamily: 'elux', color: Colors.white),
              onConfirmation: () {
                navigate(context, PageOnSpot());
              },
            )
          ],
        ),
      ),
    );
  }
}
