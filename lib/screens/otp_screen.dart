import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  OtpScreen({
    this.phoneNumber,
  });

  @override
  _OtpScreenState createState() => new _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 600;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String mobile;
  bool _isSubmitting, _isResend;

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Text(
      "Verification Code",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'GoogleSans-Medium',
        fontSize: 28.0,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Return "Email" label
  get _getMobileLabel {
    return Text(
      "Please enter the OTP sent\non your registered Mobile number.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'GoogleSans-Regular',
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getVerificationCodeLabel,
        _getMobileLabel,
        _isSubmitting == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  kPrimaryColor,
                ),
              )
            : _getInputField,
        _hideResendButton ? _getTimerText : _getResendButton,
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(
              _controller,
              15.0,
              Colors.black,
            )
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return InkWell(
      child: Container(
        height: 32,
        width: 120,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(32),
        ),
        alignment: Alignment.center,
        child: Text(
          "Resend OTP",
          style: TextStyle(
            fontFamily: 'GoogleSans-Regular',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        _resendOtp();
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return Container(
      height: _screenSize.width - 80,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "1",
                    onPressed: () {
                      _setCurrentDigit(1);
                    }),
                _otpKeyboardInputButton(
                    label: "2",
                    onPressed: () {
                      _setCurrentDigit(2);
                    }),
                _otpKeyboardInputButton(
                    label: "3",
                    onPressed: () {
                      _setCurrentDigit(3);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {
                      _setCurrentDigit(4);
                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {
                      _setCurrentDigit(5);
                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {
                      _setCurrentDigit(6);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {
                      _setCurrentDigit(7);
                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {
                      _setCurrentDigit(8);
                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {
                      _setCurrentDigit(9);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 80.0,
                ),
                _otpKeyboardInputButton(
                    label: "0",
                    onPressed: () {
                      _setCurrentDigit(0);
                    }),
                _otpKeyboardActionButton(
                  label: Icon(
                    Icons.backspace,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        if (_fourthDigit != null) {
                          _fourthDigit = null;
                        } else if (_thirdDigit != null) {
                          _thirdDigit = null;
                        } else if (_secondDigit != null) {
                          _secondDigit = null;
                        } else if (_firstDigit != null) {
                          _firstDigit = null;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    mobile = widget.phoneNumber;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/LoginScreen');
            }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: _screenSize.width,
        child: _getInputPart,
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: Text(
        digit != null ? digit.toString() : "",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(
      () {
        _currentDigit = i;
        if (_firstDigit == null) {
          _firstDigit = _currentDigit;
        } else if (_secondDigit == null) {
          _secondDigit = _currentDigit;
        } else if (_thirdDigit == null) {
          _thirdDigit = _currentDigit;
        } else if (_fourthDigit == null) {
          _fourthDigit = _currentDigit;

          var otp = _firstDigit.toString() +
              _secondDigit.toString() +
              _thirdDigit.toString() +
              _fourthDigit.toString();
          _isSubmitting = true;
          _verifyOtp(otp);
        }
      },
    );
  }

  void _resendOtp() async {
    http.Response response = await http.get(
      'https://shopkart-inc.herokuapp.com/api/users/retryVerification/$mobile',
    );
    final responseData = json.decode(response.body);
    final String errorMsg = responseData['message'];
    if (response.statusCode == 200) {
      setState(() {
        _isResend = false;
      });
      _showSuccessSnack(responseData['message']);
      _redirectUser();
      print(responseData);
    } else {
      setState(() {
        _isResend = false;
      });
      _showErrorSnackBar(errorMsg);
    }
  }

  void _verifyOtp(String otp) async {
    http.Response response = await http.post(
      'https://shopkart-inc.herokuapp.com/api/users/verifyMobile/$mobile',
      body: {"otp": otp},
    );
    final responseData = json.decode(response.body);
    final String errorMsg = responseData['message'];
    if (response.statusCode == 200) {
      setState(() {
        _isSubmitting = false;
      });
      _showSuccessSnack(responseData['message']);
      _redirectUser();
      print(responseData);
    } else {
      setState(() {
        _isSubmitting = false;
      });
      _showErrorSnackBar(errorMsg);
    }
  }

  void _showSuccessSnack(String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.green,
          fontFamily: 'Google-Sans Medium',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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

  void _redirectUser() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  final double fontSize;
  final Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Text(
          timerString,
          style: TextStyle(
            fontSize: fontSize,
            color: timeColor,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
