import 'dart:ui';
import 'package:eas/utils/utils.dart';
import 'package:eas/views/pageOnDuty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class PageServiceOrderDetail extends StatefulWidget {
  final data;
  final index;

  PageServiceOrderDetail(this.data, this.index);

  @override
  _PageServiceOrderDetailState createState() => _PageServiceOrderDetailState();
}

class _PageServiceOrderDetailState extends State<PageServiceOrderDetail> {
  TextEditingController customerName = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isSetDateAppointment = false;
  bool wasCall = false;

  List<PhoneCallEvent> _phoneEvents;

  @override
  void initState() {
    super.initState();
    _phoneEvents = _accumulate(FlutterPhoneState.phoneCallEvents);
  }

  List<R> _accumulate<R>(Stream<R> input) {
    final items = <R>[];
    input.forEach((item) {
      if (item != null) {
        setState(() {
          items.add(item);
        });
      }
    });
    return items;
  }

  /// Extracts a list of phone calls from the accumulated events
  Iterable<PhoneCall> get _completedCalls => Map.fromEntries(_phoneEvents.reversed.map((PhoneCallEvent event) {
        return MapEntry(event.call.id, event.call);
      })).values.where((c) => c.isComplete).toList();

  @override
  Widget build(BuildContext context) {
    customerName.text = widget.data.customerName;
    customerPhone.text = '081228809923';
    customerAddress.text =
        'Gedung Mandiri, Jl. RS. Fatmawati Raya No.75, RT.6/RW.5, Cipete Utara, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12150';

    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _header(),
        _soDetail(),
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
                    'Informasi Service Order',
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

  Widget _soDetail() {
    var index = widget.index;
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
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.data.soDate),
                          Text(widget.data.reffNumber, style: TextStyle(fontFamily: 'elux', color: mainColor)),
                          widget.index % 3 == 0
                              ? Text('Alasan Ditunda : Alasan $index', style: TextStyle(fontFamily: 'elux', color: mainColor))
                              : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(width: 40,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180), color: widget.index % 2 == 0 ? Colors.orange : Colors.red),
                        child: Text(
                          widget.index % 2 == 0 ? 'Ditunda' :  widget.index % 3 == 0 ? 'Belum Dikerjakan' : 'Pelanggan belum angkat telepon',
                          style: TextStyle(fontFamily: 'elux', color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(color: mainColor, height: 40, thickness: 1),
                Text('Infomasi Pelanggan',
                    style: TextStyle(fontFamily: 'elux', color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                TextField(
                  controller: customerName,
                  maxLines: null,
                  style: TextStyle(fontFamily: 'elux', color: mainColor, fontSize: 14),
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: mainColor),
                    disabledBorder: InputBorder.none,
                  ),
                ),
                TextField(
                  style: TextStyle(fontFamily: 'elux', color: mainColor, fontSize: 14),
                  enabled: false,
                  maxLines: null,
                  controller: customerAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.location_on, color: mainColor),
                    disabledBorder: InputBorder.none,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(fontFamily: 'elux', color: mainColor, fontSize: 14),
                  enabled: false,
                  maxLines: null,
                  controller: customerPhone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.phone, color: mainColor),
                    labelStyle: TextStyle(fontFamily: 'elux', color: mainColor),
                    disabledBorder: InputBorder.none,
                  ),
                ),
                Divider(color: mainColor, height: 40, thickness: 1),
                Text('Infomasi Keluhan',
                    style: TextStyle(fontFamily: 'elux', color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(widget.data.productType, style: TextStyle(fontFamily: 'elux', color: mainColor)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text("Barang tidak bekerja dengan baik sama sekali. " + widget.data.problemType,
                      style: TextStyle(fontFamily: 'elux', color: Colors.red)),
                ),
                SizedBox(height: 100),
                isSetDateAppointment == false
                    ? Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onLongPress: ()=> _confirmCallIsAnswer(),
                                onTap: () => _onCallCustomer(),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(180),
                                      ),
                                      child: Icon(Icons.phone, color: Colors.white, size: 30),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Hubungi Pelanggan', style: TextStyle(fontFamily: 'elux', color: mainColor)),
                                  ],
                                ),
                              ),
                            ),
                            if (wasCall == true)
//                            if (_completedCalls.isNotEmpty)
//                              if (_completedCalls.first.events.toString().contains('status: disconnected'))
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _setScheduleModal(),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.circular(180),
                                        ),
                                        child: Icon(Icons.today, color: Colors.white, size: 30),
                                      ),
                                      SizedBox(height: 10),
                                      Text('Atur Jadwal', style: TextStyle(fontFamily: 'elux', color: mainColor)),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () => _reScheduleModal(),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: mainColor),
                            child: Row(
                              children: [
                                Icon(Icons.today, color: Colors.white),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Anda sudah melakukan konfirmasi jadwal bertemu pada tanggal ' +
                                          DateFormat('dd-MM-yyyy').format(selectedDate) +
                                          ' Jam ' +
                                          DateFormat('HH:mm').format(selectedDate),
                                      style: TextStyle(color: Colors.white, fontFamily: 'elux'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 30),
                isSetDateAppointment == false
                    ? SizedBox.shrink()
                    : ConfirmationSlider(
                        shadow: BoxShadow(color: Colors.transparent),
                        backgroundColor: Colors.green,
                        height: 60,
                        text: 'Geser untuk memulai',
                        foregroundColor: Colors.white,
                        iconColor: mainColor,
                        textStyle: TextStyle(fontFamily: 'elux', color: Colors.white),
                        onConfirmation: () => replaceRemoveNavigate(context, PageOnDuty()),
                      ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onCallCustomer() async {
    setState(() {
      wasCall = false;
    });

    FlutterPhoneState.startPhoneCall(customerPhone.text);

    Future.delayed(
        Duration(seconds: 3),
        () => setState(() {
              _confirmCallIsAnswer();
//              confirmCallIsAnswer = true;
            }));
  }

  void _setScheduleModal() {
    showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) => {
                  setState(() {
                    selectedDate = value;
                  }),
                  print(selectedDate.minute),
                },
                minimumDate: DateTime.now(),
                use24hFormat: true,
//                minuteInterval: 15,
//                initialDateTime: DateTime.now().add(Duration(minutes: 15 - DateTime.now().minute % 15)),
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.dateAndTime,
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Batalkan', style: TextStyle(fontFamily: 'elux', color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text('Pilih', style: TextStyle(fontFamily: 'elux')),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmSchedule();
              },
            )
          ],
        );
      },
    );
  }

  void _confirmSchedule() {
    showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda akan mengunjungi pelanggan An. ' + widget.data.soDate,
                  style: TextStyle(fontFamily: 'Elux', fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  'Alamat : ' + customerAddress.text,
                  style: TextStyle(fontFamily: 'Elux', fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  'Tanggal : ' + DateFormat('dd-MM-yyyy').format(selectedDate),
                  style: TextStyle(fontFamily: 'Elux', fontSize: 14, color: Colors.green),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  'Jam : ' + DateFormat('HH:mm').format(selectedDate),
                  style: TextStyle(fontFamily: 'Elux', fontSize: 14, color: Colors.green),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Batalkan', style: TextStyle(fontFamily: 'elux', color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text('Pilih', style: TextStyle(fontFamily: 'elux')),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isSetDateAppointment = true;
                });
              },
            )
          ],
        );
      },
    );
  }

  void _reScheduleModal() {
    showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoDialogAction(
              child: Text('Telepon ulang', style: TextStyle(fontFamily: 'elux', color: mainColor)),
              onPressed: () {
                Navigator.of(context).pop();
                _onCallCustomer();
              },
            ),
            CupertinoDialogAction(
                child: Text('Konfirmasi jadwal', style: TextStyle(fontFamily: 'elux', color: mainColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _setScheduleModal();
                }),
          ],
        );
      },
    );
  }

  void _confirmCallIsAnswer() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoActionSheet(
                title: Text('Apakah Pelanggan bisa di hubungi?', style: TextStyle(fontFamily: 'elux', color: mainColor)),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Ya', style: TextStyle(fontFamily: 'elux', color: mainColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        wasCall = true;
                      });
                    },
                  ),
                  CupertinoDialogAction(
                      child: Text('Tidak', style: TextStyle(fontFamily: 'elux', color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
