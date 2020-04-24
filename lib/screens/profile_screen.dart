import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Hero(
          tag: 'logo',
          child: ShopkartLogoAppBar(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      drawer: AppDrawer(),
      backgroundColor: Color(0xffdfdfdf),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28.0),
                  bottomRight: Radius.circular(28.0),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        minRadius: 24.0,
                        maxRadius: 44.0,
                        backgroundImage: AssetImage(
                          'assets/images/shop2.jpg',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          authData.userProfile['name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF2D3E50),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GoogleSans-Regular',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          authData.userProfile['email'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kPrimaryColor,
                            fontFamily: 'GoogleSans-Regular',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          authData.userProfile['phone'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kPrimaryColor,
                            fontFamily: 'GoogleSans-Regular',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: ProfileBars(
                      icon: Icons.lock,
                      text: 'Change Password',
                      onTap: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: ProfileBars(
                      icon: FontAwesomeIcons.shoppingCart,
                      text: 'View Orders',
                      onTap: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: ProfileBars(
                      icon: FontAwesomeIcons.signOutAlt,
                      text: 'Logout',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/LoginScreen');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBars extends StatelessWidget {
  const ProfileBars({
    @required this.icon,
    @required this.text,
    @required this.onTap,
  });

  final icon;
  final String text;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: Color(0xFF2D3E50),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                text,
                style: TextStyle(color: Color(0xFF2D3E50)),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18.0,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
