import 'package:flutter/material.dart';
import 'package:shopkart_frontend/screens/profile_screen.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: ShopkartLogoAppBar(),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
        backgroundColor: Color(0xffafafaf),
        body: SingleChildScrollView(),
      ),
    );
  }
}
