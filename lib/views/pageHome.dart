import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eas/utils/color.dart';
import 'package:flutter/material.dart';

import 'PagePresence.dart';
import 'pageServiceOrder.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              child: PagePresence()
            ),
            Container(
              child: PageServiceOrder(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: mainColor,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        showElevation: false,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Presensi', style: TextStyle(fontFamily: 'elux', color: Colors.white)),
              icon: Icon(
                Icons.fingerprint,
                color: Colors.white,
              )),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              title: Text('SO', style: TextStyle(fontFamily: 'elux', color: Colors.white)),
              icon: Icon(Icons.list, color: Colors.white)),
        ],
      ),
    );
  }
}
