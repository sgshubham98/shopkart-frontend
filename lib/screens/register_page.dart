import 'package:flutter/material.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _name, _email, _mobile, _password, _confirmPassword, _referralCode;

  Widget _buildTextFied(
      BuildContext context, String labelText, bool isPassowrd) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(primaryColor: Colors.white.withOpacity(0.5)),
        child: TextField(
          obscureText: isPassowrd,
          focusNode: FocusNode(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.body1,
          ),
        ),
      ),
    );
  }

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
                              // Text(
                              //   'Name',
                              //   style: kLabelTextStyle,
                              // ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your name',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.text,
                                validator: (val) {
                                  validateName(val);
                                },
                                onSaved: (String val) {
                                  _name = val;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                                onSaved: (String val) {
                                  _email = val;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your phone',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.phone,
                                validator: validateMobile,
                                onSaved: (String val) {
                                  _mobile = val;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                onSaved: (String val) {
                                  _password = val;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Confirm password',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                onSaved: (String val) {
                                  _confirmPassword = val;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter referral code',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(
                                    Icons.text_format,
                                    color: Colors.white,
                                  ),
                                ),
                                style: kTextFormStyle,
                                keyboardType: TextInputType.text,
                                onSaved: (String val) {
                                  _referralCode = val;
                                },
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
                          onPressed: null,
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

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  // _sendToServer() {
  //   if (_key.currentState.validate()) {
  //     // No any error in validation
  //     _key.currentState.save();
  //     print("Name $_name");
  //     print("Mobile $_mobile");
  //     print("Email $_email");
  //   } else {
  //     // validation error
  //     setState(() {
  //       _validate = true;
  //     });
  //   }
  // }
}
