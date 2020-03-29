import 'package:flutter/material.dart';

class SimpleRoundButton extends StatelessWidget {
  final Color backgroundColor;
  final String buttonText;
  final Color textColor;
  final Function onPressed;

  SimpleRoundButton({
    this.backgroundColor,
    this.buttonText,
    this.textColor,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: backgroundColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: 'GoogleSans-Medium',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
