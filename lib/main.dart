import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/screens/cart_screen.dart';
import 'package:shopkart_frontend/screens/loading_screen.dart';
import 'package:shopkart_frontend/screens/otp_screen.dart';
import 'package:shopkart_frontend/screens/profile_screen.dart';
import 'package:shopkart_frontend/screens/qr_screen.dart';
import 'package:shopkart_frontend/screens/register_screen.dart';
import 'package:shopkart_frontend/screens/splash_screen.dart';
import 'package:shopkart_frontend/screens/home_page.dart';
import 'package:shopkart_frontend/screens/intro_screen.dart';
import 'package:shopkart_frontend/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: "ShopKart",
          theme: ThemeData.light(),
          home: SafeArea(
            child: auth.isAuth
                ? HomePage()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResult) =>
                        authResult.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : IntroScreen(),
                  ),
          ),
          routes: <String, WidgetBuilder>{
            '/LoadingScreen': (BuildContext context) => LoadingScreen(),
            '/IntroScreen': (BuildContext context) => IntroScreen(),
            '/LoginScreen': (BuildContext context) => LoginPage(),
            '/RegisterScreen': (BuildContext context) => RegisterPage(),
            '/OtpScreen': (BuildContext context) => OtpScreen(),
            '/HomePage': (BuildContext context) => HomePage(),
            '/ProfileScreen': (BuildContext context) => ProfileScreen(),
            '/QRScreen': (BuildContext context) => QRScreen(),
            '/CartScreen': (BuildContext context) => CartScreen(),
          },
        ),
      ),
    );
  }
}
