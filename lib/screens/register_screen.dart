import 'package:flutter/material.dart';
import 'package:shopkart_frontend/screens/login_screen.dart';
import 'package:shopkart_frontend/screens/verification_screen.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true, _obscureConfirmText = true, _isSubmitting;
  String _firstName,
      _lastName,
      _email,
      _mobile,
      _password,
      _confirmPassword,
      _referralCode,
      _role = "customer";

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
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
                          key: _formKey,
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
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _firstName = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'First name',
                                  hintText: 'Enter first name',
                                ),
                                validator: (val) {
                                  String patttern = r'(^[a-zA-Z ]*$)';
                                  RegExp regExp = RegExp(patttern);
                                  if (val.length == 0) {
                                    return "First name is Required";
                                  } else if (!regExp.hasMatch(val)) {
                                    return "First name must be a-z and A-Z";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _lastName = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Last name',
                                  hintText: 'Enter last name',
                                ),
                                validator: (val) {
                                  String patttern = r'(^[a-zA-Z ]*$)';
                                  RegExp regExp = RegExp(patttern);
                                  if (val.length == 0) {
                                    return "Last name is Required";
                                  } else if (!regExp.hasMatch(val)) {
                                    return "Last name must be a-z and A-Z";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _email = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Email',
                                  hintText: 'Enter your email',
                                ),
                                validator: (val) {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = new RegExp(pattern);
                                  if (val.length == 0) {
                                    return "Email is Required";
                                  } else if (!regExp.hasMatch(val)) {
                                    return "Invalid Email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _mobile = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Phone',
                                  hintText: 'Enter your mobile number',
                                ),
                                validator: (val) {
                                  String patttern = r'(^[0-9]*$)';
                                  RegExp regExp = new RegExp(patttern);
                                  if (val.length == 0) {
                                    return "Mobile is Required";
                                  } else if (val.length != 10) {
                                    return "Mobile number must 10 digits";
                                  } else if (!regExp.hasMatch(val)) {
                                    return "Mobile Number must be digits";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                obscureText: _obscureText,
                                onSaved: (value) {
                                  _password = value;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  hintStyle: kHintTextStyle,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.length >= 8) return null;
                                  return 'Password must be of 8 characters!';
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                obscureText: _obscureConfirmText,
                                onSaved: (value) {
                                  _confirmPassword = value;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      _obscureConfirmText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _obscureConfirmText =
                                            !_obscureConfirmText;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Confirm Password',
                                  hintText: 'Confirm your password',
                                  hintStyle: kHintTextStyle,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.length >= 8)
                                    return null;
                                  else if (val.length < 8)
                                    return 'Password must be of 8 characters!';
                                  return 'Password is required';
                                },
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _referralCode = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Referral code',
                                  hintText: 'Enter your referral code',
                                ),
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
                      children: <Widget>[
                        _isSubmitting == true
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Color(0xFF1BBC9B),
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SimpleRoundButton(
                                      backgroundColor: Color(0xFF1BBC9B),
                                      textColor: Colors.white,
                                      buttonText: 'Register',
                                      onPressed: () {
                                        _submit();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text('Existing user? Login'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    setState(() {
      _isSubmitting = true;
    });
    http.Response response = await http
        .post('https://shopkart-inc.herokuapp.com/api/users/register', body: {
      "firstName": _firstName,
      "lastName": _lastName,
      "email": _email,
      "contact": _mobile,
      "password": _password,
      "confirmPassword": _confirmPassword,
      "role": _role,
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _isSubmitting = false;
      });
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() {
        _isSubmitting = false;
      });
      final String errorMsg = responseData['message'];
      _showErrorSnackBar(errorMsg);
    }
  }

  void _showSuccessSnack() {
    final snackBar = SnackBar(
      content: Text(
        'User Successfully Registered!',
        style: TextStyle(
          color: Colors.green,
          fontFamily: 'Google-Sans Medium',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  void _showErrorSnackBar(String errorMsg){
    final snackBar = SnackBar(
      content: Text(
        errorMsg,
        style: TextStyle(
          color: Colors.red,
          fontFamily: 'Google-Sans Medium',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    // throw Exception('Error registering: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(phoneNumber: _mobile),
        ),
      );
    });
  }
}
