import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shopkart_frontend/models/app_state.dart';
import 'package:shopkart_frontend/redux/actions.dart';
import 'package:shopkart_frontend/redux/reducers.dart';
import 'package:shopkart_frontend/screens/cart_screen.dart';
import 'package:shopkart_frontend/screens/otp_screen.dart';
import 'package:shopkart_frontend/screens/profile_screen.dart';
import 'package:shopkart_frontend/screens/qr_screen.dart';
import 'package:shopkart_frontend/screens/register_screen.dart';
import 'package:shopkart_frontend/screens/splash_screen.dart';
import 'package:shopkart_frontend/screens/home_page.dart';
import 'package:shopkart_frontend/screens/intro_screen.dart';
import 'package:shopkart_frontend/screens/login_screen.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "ShopKart",
        theme: ThemeData.light(),
        initialRoute: '/SplashScreen',
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) => HomePage(
            onInit: (){
              StoreProvider.of<AppState>(context).dispatch(getUserAction);
              StoreProvider.of<AppState>(context).dispatch(getProductsAction);
            },
          ),
          '/SplashScreen': (BuildContext context) => SplashScreen(),
          '/IntroScreen': (BuildContext context) => IntroScreen(),
          '/LoginScreen': (BuildContext context) => LoginPage(),
          '/RegisterScreen': (BuildContext context) => RegisterPage(),
          '/OtpScreen': (BuildContext context) => OtpScreen(),
          '/ProfileScreen': (BuildContext context) => ProfileScreen(),
          '/QRScreen': (BuildContext context) => QRScreen(),
          '/CartScreen': (BuildContext context) => CartScreen(),
        },
      ),
    );
  }
}
