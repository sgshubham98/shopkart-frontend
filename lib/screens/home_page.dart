import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';
import 'package:shopkart_frontend/widgets/badge.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                Navigator.of(context).pushNamed('\CartScreen');
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
            Image(
              image: NetworkImage(authData.userProfile["qr"]),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.height / 4,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SimpleRoundButton(
                      onPressed: () {
                        Future.delayed(Duration(seconds: 3));
                        Navigator.pushNamed(context, '/CartScreen');
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
}
