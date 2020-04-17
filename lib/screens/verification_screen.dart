import 'package:flutter/material.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({
    @required this.phoneNumber,
  });

  final String phoneNumber;
  
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: kAppBar,
        body: SingleChildScrollView(
          child: Text('Hello'),
        ),
      ),
    );
  }
}
