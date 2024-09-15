import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const serverIp = '192.168.222.196:3000';
const serverUrl = 'http://${serverIp}';
const Color primaryColor = Color(0XFFDBD8E3);
const Color secondaryColor = Color(0XFF352F44);
const Color textColor = Color(0XFFEEEEEE);
const Color scaffoldColor = Color(0XFF2A2438);
const Color primaryActive = Color(0XFF5C5470);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  fillColor: Colors.white,
  filled: true,
);

//  New Color Palatte
// #2A2438
// #352F44
// #5C5470
// #DBD8E3


// Colour Palatte 2
// #222831
// #393E46
// #FD7014
// #EEEEEE