import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/screens/about_screen.dart';
import 'package:shopkart_frontend/screens/order_screen.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white24,
            title: ShopkartLogoAppBar(),
            centerTitle: false,
            elevation: 0.0,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Home'),
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName('/'),
              );
              Navigator.of(context).pushNamed('/HomePage');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed('/ProfileScreen');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.creditCard),
            title: Text('Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersScreen(),
                ),
              );
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.feedback),
          //   title: Text('Feedback'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(OrdersScreen.routeName);
          //   },
          // ),
          // Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.infoCircle),
            title: Text('About'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
