import 'package:flutter/material.dart';
import 'package:shopkart_frontend/widgets/introscreen_carousel.dart';
import 'dart:ui';
import 'package:shopkart_frontend/widgets/shopkart_logo.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 52.0,
              ),
              Hero(
                tag: 'logo',
                child: ShopkartLogoText(),
              ),
              SizedBox(
                height: 24.0,
              ),
              CarouselDemo(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 42.0,
                  left: 42.0,
                  top: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SimpleRoundButton(
                        backgroundColor: Color(0xFF2D3E50),
                        buttonText: 'Sign in',
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/LoginScreen');
                        },
                      ),
                    ),
                    SizedBox(width: 32.0),
                    Expanded(
                      child: SimpleRoundButton(
                        backgroundColor: Color(0xFF1BBC9B),
                        buttonText: 'Register',
                        textColor: Color(0xFFFFFFFF),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/RegisterScreen');
                        },
                      ),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
