import 'package:flutter/material.dart';

class ShopkartLogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'shop',
          style: TextStyle(
            fontFamily: "Sacramento",
            fontSize: 48.0,
            color: Color(0xFF2D3E50), 
          ),
        ),
        Text(
          'kart',
          style: TextStyle(
            fontFamily: "Sacramento",
            fontSize: 48.0,
            color: Color(0xFF1BBC9B), 
          ),
        ),
      ],
    );
  }
}