import '../utils/utils.dart';
import 'package:eas/views/pageServiceOrderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

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

  MessageItem(this.reffNumber, this.soDate, this.problemType, this.productType, this.customerName);

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

class _PageServiceOrder extends State<PageServiceOrder> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  List<ListItem> items = List<ListItem>.generate(
    12,
    (i) => MessageItem(
        "Nomor Referensi : $i", "Tanngal SO : 27-08-2020", "Tipe Kerusakan : $i", "Model Barang : $i", "Customer : $i"),
  );

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      DateTime.parse('2020-09-15'): [
        'Event A0',
        'Event B0',
        'Event C0',
        'Event C0',
        'Event C0',
        'Event C0',
        'Event C0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print(first.toString().split(' ')[0]+' - '+last.toString().split(' ')[0]);
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

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
            _calendar(),
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

  Widget _calendar() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 7),
        Expanded(child: _buildTableCalendarWithBuilders()),

//        Expanded(
//          child: Container(
//            decoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//            ),
//            padding: EdgeInsets.only(top: 10),
//            child: ListView.builder(
//              scrollDirection: Axis.vertical,
//              shrinkWrap: true,
//              physics: BouncingScrollPhysics(),
//              itemCount: items.length,
//              itemBuilder: (context, index) {
//                final item = items[index];
//                return ListTile(
//                    title: item.buildTitle(context),
//                    subtitle: item.buildSubtitle(context),
//                    isThreeLine: true,
//                    onTap: () => navigate(context, PageServiceOrderDetail(items[index], items.indexOf(items[index]))),
//                    trailing: Container(
//                      width: 70,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: [
//                          Icon(items.indexOf(items[index]) % 2 == 0 ? Icons.watch_later : Icons.warning,
//                              color: items.indexOf(items[index]) % 2 == 0 ? Colors.orangeAccent : Colors.red,
//                              semanticLabel: items.indexOf(items[index]) % 3 == 0 ? "Selesai" : "Belum Selesai"),
//                          SizedBox(width: 10),
//                          GestureDetector(
//                            onTap: () {},
//                            child: Icon(
//                                items.indexOf(items[index]) % 2 == 0
//                                    ? Icons.phone
//                                    : items.indexOf(items[index]) % 3 == 0 ? Icons.phone : Icons.phone_missed,
//                                color: items.indexOf(items[index]) % 2 == 0 ? Colors.green : Colors.red),
//                          ),
//                        ],
//                      ),
//                    ));
//              },
//            ),
//          ),
//        ),
      ],
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          TableCalendar(
            locale: 'id',
            calendarController: _calendarController,
            events: _events,
            initialCalendarFormat: CalendarFormat.month,
            formatAnimation: FormatAnimation.slide,
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableGestures: AvailableGestures.horizontalSwipe,
            availableCalendarFormats: const {
              CalendarFormat.month: '',
              CalendarFormat.week: '',
            },
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle().copyWith(color: mainColor, fontSize: 15.0, fontFamily: 'elux'),
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              todayStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0, fontFamily: 'elux'),
              outsideDaysVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle().copyWith(color: Colors.red[600], fontFamily: 'elux'),
            ),
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
//              width: 100,
//              height: 100,
                    decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(180)),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(fontFamily: 'elux', color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              todayDayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: mainColorWithOpacity,
                  ),
//            width: 100,
//            height: 100,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(fontFamily: 'elux', color: Colors.white),
                    ),
                  ),
                );
              },
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];

                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                return children;
              },
            ),
            onDaySelected: (date, events) {
              _onDaySelected(date, events);
              _animationController.forward(from: 0.0);
            },
            onVisibleDaysChanged: _onVisibleDaysChanged,
            onCalendarCreated: _onCalendarCreated,
          ),
          _buildEventList(),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.amber[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(color: Colors.white, fontSize: 12.0, fontFamily: 'elux'),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Column(
      children: _selectedEvents
          .map((event) =>
          Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: mainColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString(), style: TextStyle(fontFamily: 'elux')),
          onTap: () => print('$event tapped!'),
        ),
      )
      )
          .toList(),
    );

  }
}
