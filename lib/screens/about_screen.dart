import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
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
        title: Text("About"),
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
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/CartScreen');
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 16.0,
                          maxRadius: 28.0,
                          backgroundImage: NetworkImage('https://avatars2.githubusercontent.com/u/30005684?s=460&u=b4bc58443f6c7945259804492190ada5d5016a34&v=4'),
                        ),
                        Text('\nAakash Goel'),
                        Row(
                          children: <Widget>[
                            GestureDetector(child: Icon(FontAwesomeIcons.github), onTap: ()=> _launchURL('https://github.com/goelaakash79')),
                            Icon(FontAwesomeIcons.linkedinIn),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 16.0,
                          maxRadius: 28.0,
                          backgroundImage: NetworkImage('https://avatars3.githubusercontent.com/u/47817908?s=460&u=5ffaf0b9ff11703c647e77fed348d423dd309379&v=4'),
                        ),
                        Text('\nRitwick Bhargav'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(child: Icon(FontAwesomeIcons.githubAlt), onTap: ()=> _launchURL('https://github.com/ritwickbhargav80')),
                            Icon(FontAwesomeIcons.linkedinIn),
                          ],
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 16.0,
                          maxRadius: 28.0,
                          backgroundImage: NetworkImage('https://media-exp1.licdn.com/dms/image/C4E03AQG6zBMpxYBsZA/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=TrqGyaA8IllM_hfVKvxcu32Ik-w_aZG1yPYeIV4pcws'),
                        ),
                        Text('\nShreeyanshi Gupta'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(child: Icon(FontAwesomeIcons.githubAlt), onTap: ()=> _launchURL('https://github.com/shrynshigupta06')),
                            Icon(FontAwesomeIcons.linkedinIn),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 16.0,
                          maxRadius: 28.0,
                          backgroundImage: NetworkImage('https://avatars3.githubusercontent.com/u/47817908?s=460&u=5ffaf0b9ff11703c647e77fed348d423dd309379&v=4'),
                        ),
                        Text('\nShubham Goswami'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(child: Icon(FontAwesomeIcons.githubAlt), onTap: ()=> _launchURL('https://github.com/sgshubham98')),
                            Icon(FontAwesomeIcons.linkedinIn),
                          ],
                        ),
                      ],
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}