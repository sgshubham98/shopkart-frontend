import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Hero(
          tag: 'logo',
          child: ShopkartLogoAppBar(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.shoppingCart,
              color: kPrimaryColor,
            ),
            onPressed: () {
            },
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
            Text(
              'Hello ',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.start,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Orders',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GoogleSans-Medium',
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'view all',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'GoogleSans-Medium',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: PageView.builder(
                itemCount: 10,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Order ${i + 1}",
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Image(
              image: NetworkImage(''),
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
                        Navigator.pushNamed(context, '/QRScreen');
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
