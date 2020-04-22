import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/models/http_exception.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/screens/otp_screen.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _mobile, _password;
  bool _obscureText = true, _isSubmitting;
  Map<String, String> _authData = {
    'mobile': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                              'Let\'s go',
                              style: kTextStyle,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Theme(
                              data: ThemeData(
                                primaryColor: kSecondaryColor,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _authData['mobile'] = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Mobile number',
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
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Theme(
                              data: ThemeData(
                                primaryColor: kSecondaryColor,
                              ),
                              child: TextFormField(
                                obscureText: _obscureText,
                                onSaved: (value) {
                                  _authData['password'] = value;
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
                                    buttonText: 'Log in',
                                    onPressed: () {
                                      _submit();
                                    },
                                  ),
                                ),
                              ],
                            ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/RegisterScreen');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/RegisterScreen');
                        },
                        child: Text(
                          'New user? Register',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
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
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _loginUser();
    }
  }

  void _loginUser() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        _authData['mobile'],
        _authData['password'],
      ).timeout(const Duration(seconds: 30), onTimeout: _onTimeout);
      Navigator.pushReplacementNamed(context, '/HomePage');
    } on HttpException catch (error) {
      var errorMessage = "Authentication failed!";
      if (error.toString().contains('Mobile') &&
          error.toString().contains('Email')) {
        setState(() {
          _isSubmitting = false;
        });
        errorMessage = error.toString();
        _showErrorSnackBar(errorMessage);
        _redirectUserToOtp();
      } else {
        errorMessage = error.toString();
        _showErrorSnackBar(errorMessage);
      }
    }
    setState(() {
      _isSubmitting = false;
    });
  }

  void _showErrorSnackBar(String errorMsg) {
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
  }

  void _redirectUserToOtp() {
    Future.delayed(
        Duration(
          seconds: 0,
        ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNumber: _mobile,
            password: _password,
          ),
        ),
      );
    });
  }

  void _onTimeout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Shopkart'),
        content: Text('Oopss...Request Time Out !!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
