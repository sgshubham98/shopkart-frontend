import 'package:flutter/material.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';

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

const kHintTextStyle = TextStyle(fontFamily: 'GoogleSans-Regular');

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  labelText: 'Enter a value',
  hintText: 'Enter a value',
  hintStyle: kHintTextStyle,
  border: OutlineInputBorder(),
);

var kAppBar = AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  title: ShopkartLogoAppBar(),
);

final String apiUrl = 'https://shopkart-inc.herokuapp.com/';
final String apiUserRegister = 'api/users/register';
