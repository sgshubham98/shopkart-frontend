import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/shop_status_provider.dart';
import 'package:shopkart_frontend/screens/cart_screen.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';
import 'package:shopkart_frontend/widgets/badge.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:shopkart_frontend/utilities/routes.dart' as api;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSubmitting;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Hero(
          tag: 'logo',
          child: ShopkartLogoAppBar(),
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Provider.of<ShopStatus>(context).status == true
                    ? Navigator.of(context).pushNamed('/CartScreen')
                    : Fluttertoast.showToast(
                        msg: 'Please scan your QR to enter shop',
                      );
              },
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/walk_cart.gif',
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            Image(
              image: NetworkImage(authData.userProfile["qr"] == null
                  ? ''
                  : authData.userProfile["qr"]),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.height / 3,
            ),
            SizedBox(
              height: 14.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isSubmitting == true
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Color(0xFF1BBC9B),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SimpleRoundButton(
                            onPressed: () {
                              final url =
                                  Uri.http(api.BASE_URL, api.SHOP_STATUS);
                              _checkStatus(url);
                              // Fluttertoast.showToast(
                              //         msg: 'Please scan your QR to enter shop');
                            },
                            backgroundColor: kSecondaryColor,
                            buttonText: 'Start Shopping',
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _checkStatus(url) async {
    setState(() {
      _isSubmitting = true;
    });
    final authData = Provider.of<AuthProvider>(context, listen: false);
    try {
      final response = await http.get(
        url,
        headers: {
          "x-auth-token": authData.token,
        },
      );
      if (response == null) {
        return;
      }
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Provider.of<ShopStatus>(context).changeStatus(responseData['inShop']);
        Fluttertoast.showToast(
            msg: responseData['message'], timeInSecForIosWeb: 3);
      } else {
        Fluttertoast.showToast(
            msg: responseData['message'], timeInSecForIosWeb: 2);
      }
      setState(() {
        _isSubmitting = false;
      });
      if(responseData['message'] == 'You can enjoy shopping now!') {
        Future.delayed(Duration(seconds: 1));
        Navigator.pushNamed(context, '/CartScreen');
      }
    } catch (error) {
      throw (error);
    }
  }
}
