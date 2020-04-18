import 'package:flutter/material.dart';
import 'package:shopkart_frontend/screens/register_screen.dart';
import 'package:shopkart_frontend/screens/splash_screen.dart';
import 'package:shopkart_frontend/screens/home_page.dart';
import 'package:shopkart_frontend/screens/intro_screen.dart';
import 'package:shopkart_frontend/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ShopKart",
      theme: ThemeData.light(),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => HomePage(),
        '/IntroScreen': (BuildContext context) => IntroScreen(),
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/RegisterPage': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
