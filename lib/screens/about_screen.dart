import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/shop_status_provider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/utilities/routes.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';
import 'package:shopkart_frontend/widgets/badge.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          "About",
          style: TextStyle(
            color: kAuthBGColor,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: kAuthBGColor,
              ),
              onPressed: () {
                Provider.of<ShopStatus>(context).status == true
                            ? Navigator.pushNamed(context, '/CartScreen')
                            : Fluttertoast.showToast(
                                msg: 'Please scan your QR to enter shop');
                // Navigator.of(context).pushNamed('/CartScreen');
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'About Shopkart!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Shopkart is a mobile and web-based application that combines the best features of online and offline modes of shopping and provides the user with a unique way to shop. It could relieve the users with the issues faced by them while shopping in marts or dissatisfaction in online shopping.',
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Team',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                AboutCard(
                  AAKASH_IMAGE_URL,
                  'Aakash Goel',
                  'Frontend & Design',
                  AAKASH_GITHUB_URL,
                  AAKASH_GITHUB_URL,
                ),
                AboutCard(
                  RITWICK_IMAGE_URL,
                  'Ritwick Bhargav',
                  'Backend',
                  RITWICK_GITHUB_URL,
                  RITWICK_LINKEDIN_URL,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                AboutCard(
                  GOSWAMI_IMAGE_URL,
                  'Shubham Goswami',
                  'Mobile App',
                  GOSWAMI_GITHUB_URL,
                  GOSWAMI_LINKEDIN_URL,
                ),
                AboutCard(
                  SHREE_IMAGE_URL,
                  'Shreeyanshi Gupta',
                  'Backend',
                  SHREE_GITHUB_URL,
                  SHREE_LINKEDIN_URL,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final imageUrl;
  final name;
  final role;
  final githubUrl;
  final linkedinUrl;
  AboutCard(
    this.imageUrl,
    this.name,
    this.role,
    this.githubUrl,
    this.linkedinUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                minRadius: 16.0,
                maxRadius: 28.0,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              role,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.github),
                    onPressed: () => _launchURL(githubUrl),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.linkedinIn),
                    onPressed: () => _launchURL(linkedinUrl),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: 'Could not launch $url', timeInSecForIosWeb: 2);
      throw 'Could not launch $url';
    }
  }
}
