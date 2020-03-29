import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/screens/splash_screen.dart';
import 'package:shopkart_frontend/screens/home_page.dart';
import 'package:shopkart_frontend/screens/intro_screen.dart';
import 'package:shopkart_frontend/screens/register_screen.dart';
import 'package:shopkart_frontend/screens/login_screen.dart';
import 'package:shopkart_frontend/providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: "ShopKart",
          theme: ThemeData.light(),
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : IntroScreen(),
                ),
          routes: <String, WidgetBuilder>{
            '/HomePage': (BuildContext context) => HomePage(),
            '/IntroScreen': (BuildContext context) => IntroScreen(),
            '/LoginPage': (BuildContext context) => LoginPage(),
            '/RegisterPage': (BuildContext context) => RegisterPage(),
            // RegisterPage().id : (BuildContext context) => RegisterPage(),
          },
        ),
      ),
    );
  }
}
