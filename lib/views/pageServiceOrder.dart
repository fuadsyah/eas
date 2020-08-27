import 'package:eas/utils/utils.dart';
import 'package:eas/views/pageServiceOrderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
//class HeadingItem implements ListItem {
//  final String heading;
//
//  HeadingItem(this.heading);
//
//  Widget buildTitle(BuildContext context) {
//    return Text(
//      heading,
//      style: Theme.of(context).textTheme.headline5,
//    );
//  }
//
//  Widget buildSubtitle(BuildContext context) => null;
//}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String reffNumber;
  final String soDate;
  final String problemType;
  final String productType;
  final String customerName;

  MessageItem(this.reffNumber, this.soDate, this.problemType, this.productType,  this.customerName);

  Widget buildTitle(BuildContext context) => Text(soDate, style: TextStyle(fontFamily: 'elux'));

  Widget buildSubtitle(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(problemType, style: TextStyle(fontFamily: 'elux', fontSize: 12))),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(productType, style: TextStyle(fontFamily: 'elux', fontSize: 12))),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(reffNumber, style: TextStyle(fontFamily: 'elux', fontSize: 10))),
            ],
          ),
        ],
      );
}

class PageServiceOrder extends StatefulWidget {
  @override
  _PageServiceOrder createState() => _PageServiceOrder();
}

class _PageServiceOrder extends State<PageServiceOrder> {
  List<ListItem> items = List<ListItem>.generate(
    12,
    (i) => MessageItem(
        "Nomor Referensi : $i", "Tanngal SO : 26-08-2020", "Tipe Kerusakan : $i", "Model Barang : $i", "Customer : $i"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Container(
        child: Stack(
          children: [
            _header(),
            _listingOrder(),
          ],
        ),
      ),
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
                    'Service Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'elux',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.history, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listingOrder() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 7),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            padding: EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                    title: item.buildTitle(context),
                    subtitle: item.buildSubtitle(context),
                    isThreeLine: true,
                    onTap: () => navigate(context, PageServiceOrderDetail(items[index], items.indexOf(items[index]))),
                    trailing: Container(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(items.indexOf(items[index]) % 2 == 0 ? Icons.watch_later : Icons.warning,
                              color: items.indexOf(items[index]) % 2 == 0 ? Colors.orangeAccent : Colors.red,
                              semanticLabel: items.indexOf(items[index]) % 3 == 0 ? "Selesai" : "Belum Selesai"),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(items.indexOf(items[index]) % 2 == 0 ? Icons.phone : items.indexOf(items[index]) % 3 ==0 ? Icons.phone : Icons.phone_missed,
                                color: items.indexOf(items[index]) % 2 == 0 ? Colors.green : Colors.red),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
