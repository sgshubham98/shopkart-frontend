import 'package:flutter/material.dart';
import 'package:shopkart_frontend/screens/register_screen.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _obscureText = true;

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
                          buttonText: 'Log in',
                          onPressed: (){
                            _submit();
                          },
                        ),
                        FlatButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                          },
                          child: Text('New user? Register'),
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
  void _submit() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
    }
  }
}
