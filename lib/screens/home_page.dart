import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shopkart_frontend/models/app_state.dart';
import 'package:shopkart_frontend/screens/cart_screen.dart';
import 'package:shopkart_frontend/screens/profile_screen.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;

  HomePage({this.onInit});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

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
              Navigator.pushReplacementNamed(
                context,
                '/HomePage',
              );
            },
          ),
          actions: <Widget>[
            StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state){
                          return IconButton(
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(name: state.user.username, email: state.user.email, mobile: state.user.mobile,),
                    ),
                  );
                },
              );
          },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) {
              return Column(
                children: <Widget>[
                  Text(
                    'Hello ${state.user.username}',
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
                      onPageChanged: (int index) =>
                          setState(() => _index = index),
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
                    image: NetworkImage(state.user.userQR),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
