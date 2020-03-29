import 'package:flutter/material.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _name, _email, _mobile, _password, _confirmPassword, _referralCode;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 52.0),
                    child: ShopkartLogoText(),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: screenWidth - 84,
                      color: kAuthBGColor,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _key,
                          autovalidate: _validate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Become a member',
                                style: kTextStyle,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Name',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _name = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your name'),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Email',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _email = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your email'),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Phone Number',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _mobile = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your mobile number'),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Password',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _password = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password'),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Confirm Password',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextField(
                                obscureText: true,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _confirmPassword = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Confirm your password'),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Referral Code (optional)',
                                  style: kLabelTextStyle,
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _password = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your referral code'),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 42.0, left: 42.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SimpleRoundButton(
                          backgroundColor: Color(0xFF1BBC9B),
                          textColor: Colors.white,
                          buttonText: 'Register',
                          onPressed: (){
                            print(_password);
                            print(_name);
                            print(_mobile);
                            print(_email);
                            print(_confirmPassword);
                            print(_referralCode);
                            print(_validate);
                            if (!_validate) {
                              Navigator.pushNamed(context, '/HomePage');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 42.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
