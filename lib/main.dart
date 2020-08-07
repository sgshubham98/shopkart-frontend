import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart';
import 'package:shopkart_frontend/providers/products_provider.dart';
import 'package:shopkart_frontend/providers/shop_status_provider.dart';
import 'package:shopkart_frontend/screens/cart_screen.dart';
import 'package:shopkart_frontend/screens/otp_screen.dart';
import 'package:shopkart_frontend/screens/profile_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: ShopStatus()),
        ChangeNotifierProxyProvider<AuthProvider, Products>(
          builder: (context, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.products,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
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
            '/IntroScreen': (BuildContext context) => IntroScreen(),
            '/LoginScreen': (BuildContext context) => LoginPage(),
            '/RegisterScreen': (BuildContext context) => RegisterPage(),
            '/OtpScreen': (BuildContext context) => OtpScreen(),
            '/HomePage': (BuildContext context) => HomePage(),
            '/ProfileScreen': (BuildContext context) => ProfileScreen(),
            '/CartScreen': (BuildContext context) => CartScreen(),
          },
        ),
      ),
    );
  }
}
