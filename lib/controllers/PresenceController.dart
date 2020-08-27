import 'dart:async';
import 'dart:io';

import 'package:eas/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:trust_location/trust_location.dart';
import '../views/PagePresence.dart';

abstract class PresenceController extends State<PagePresence> {
  String latitude = '0';
  String longitude ='0';
  double storeLatitude = -6.261014;
  double storeLongitude = 106.796845;
  String locationFromGeolocator;
  String distanceToLocation ='0';

  var headerHeight;
  var timer;
  var timeString;

  bool statusCheckIn = false;
  File checkInImage;
  File checkOutImage;

  /// initialize state.
  @override
  void initState() {
    super.initState();
    initFunction();
  }

  void initFunction() async {
    requestLocationPermission();

    TrustLocation.start(1);

    getLocation();

    setClock();

    Timer.periodic(
        Duration(seconds: 2),
        (Timer t) async => await getGeoCoder().then((value) async {
              if (mounted) {
                setState(() {
                  locationFromGeolocator = value;
                });
                await getDistance().then((distance) {
                  setState(() {
                    distanceToLocation = distance;
                  });
                });

//                print(distanceToLocation);
              }
            }));
  }

  /// get location method, use a try/catch PlatformException.
  Future<void> getLocation() async {
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
  }

  /// request location permission at runtime.
  void requestLocationPermission() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
    print('permissions: $permission');
  }

  ///Get Location Name
  Future<String> getGeoCoder() async {
    if (latitude != null && longitude != null) {
      // From coordinates
      List<Placemark> placeMark = await Geolocator().placemarkFromCoordinates(double.parse(latitude), double.parse(longitude));
      final Placemark pos = placeMark[0];
      if (pos != null) {
        String place = pos.thoroughfare +
            ' ' +
            pos.subThoroughfare +
            ', ' +
            pos.locality +
            ' ' +
            pos.subLocality +
            ', ' +
            pos.administrativeArea +
            ' ' +
            pos.subAdministrativeArea +
            ', ' +
            pos.postalCode;
        return place.toString();
      } else {
        return "Menuggu Lokasi";
      }
    } else {
      return "Menuggu Lokasi";
    }
  }

  ///Calculate distance
  Future<String> getDistance() async {
    if (latitude != null && longitude != null && storeLatitude != null && storeLongitude != null) {
      double distanceInMeters =
          await Geolocator().distanceBetween(storeLatitude, storeLongitude, double.parse(latitude), double.parse(longitude));

      return distanceInMeters.round().toString();
    } else {
      return 'Menunggu Kordinat';
    }
  }

  ///Get live clock
  void setClock() async {
    timeString = formatClock(DateTime.now());
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => getTime().then((time) {
        setState(() {
          if (mounted) {
            timeString = time;
          }
        });
      }),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future openCheckInCamera() async {
    var imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    await compressImage(File(imageFile.path)).then((image) {
      setState(() {
        checkInImage = image;
      });
    });
  }

  Future openCheckOutCamera() async {
    if (statusCheckIn == false) {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        msg: "Anda belum melakukan absen masuk",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } else {
      var imageFile = await ImagePicker().getImage(source: ImageSource.camera);

      await compressImage(File(imageFile.path)).then((image) {
        setState(() {
          checkOutImage = image;
        });
      });
    }
  }
}
