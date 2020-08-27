import 'package:eas/utils/utils.dart';
import 'package:flutter/material.dart';

import 'pageHome.dart';

class PageLogin extends StatefulWidget{

  @override
  _PageLoginState createState()=> _PageLoginState();
}

class _PageLoginState extends State<PageLogin>{

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _background(),
        _backgroundOverlay(),
        _title(),
        _loginForm(),
      ],
    );
  }

  Widget _background() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Image.asset(
        'assets/background/bg2.png',
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Electrolux Authorized Service',
              style: TextStyle(fontFamily: 'elux', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  Widget _backgroundOverlay() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//          mainColor,
          Colors.black,
          Colors.transparent,
        ], stops: [
          0.1,
          1.0,
        ]),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 2.3),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Masuk dengan akun Anda',
                          style: TextStyle(fontFamily: 'elux', fontSize: 20, fontWeight: FontWeight.bold, color: mainColor),
                        ),
                      ),
                      SizedBox(width: 30),
                      Image.asset('assets/logo/elux2.png', width: 50),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: username,
                    style: TextStyle(fontFamily: 'elux'),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person, color: mainColor),
                      focusColor: mainColor,
                      fillColor: mainColor,
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: password,
                    style: TextStyle(fontFamily: 'elux'),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: mainColor,
                      ),
                      focusColor: mainColor,
                      fillColor: mainColor,
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      replaceNavigate(context, PageHome());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(180),
                      ),
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white, fontFamily: 'elux', fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}