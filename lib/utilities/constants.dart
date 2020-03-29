import 'package:flutter/material.dart';

const kButtonTextStyle = TextStyle(
  fontFamily: 'GoogleSans-Medium',
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const kAuthBGColor = Color(0xFF2D3E50);

const kTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'GoogleSans-Regular',
  fontWeight: FontWeight.bold,
);

const kLabelTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  letterSpacing: 0.5,
  fontFamily: 'GoogleSans-Medium',
);

const kTextFormStyle = TextStyle(
  color: Colors.white,
);

const kHintTextStyle = TextStyle(
  // color: Colors.white,
  fontFamily: 'GoogleSans-Regular'
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter a value',
  hintStyle: kHintTextStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);
