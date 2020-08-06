import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class OrderStatus extends StatefulWidget {
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  bool status;

  @override
  void initState() {
    super.initState();
    _orderSucess();
  }

  void _orderSucess() async {
    final cart = Provider.of<Cart>(context, listen: false);
    try {
      // print(cart.totalAmount);
      // print(cart.items.values.toList());
      int statusCode =
          await Provider.of<Orders>(context, listen: false).addOrder(
        cart.items.values.toList(),
        cart.totalAmount,
      );
      if (statusCode == 200) {
        cart.clearCart();
        setState(() {
          status = true;
        });
      } else {
        setState(() {
          status = false;
        });
      }
    } catch (e) {
      print('***********************************************\n' +
          e.toString() +
          '\n***********************************************\n');
      // Navigator.pushReplacementNamed(context, '/HomePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child:
                status == true ? _orderSuccess(authData) : _orderFail(authData),
          ),
        ),
      ),
    );
  }

  Widget _orderSuccess(AuthProvider authData) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/success.gif'),
          height: 120.0,
          width: 120.0,
        ),
        Text('Order Successfully Placed!'),
        SizedBox(
          height: 16.0,
        ),
        Image(
          image: NetworkImage(authData.userProfile["qr"] == null
              ? ''
              : authData.userProfile["qr"]),
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
                  buttonText: 'Continue Shopping',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SimpleRoundButton(
                  onPressed: () {
                    Future.delayed(Duration(seconds: 3));
                    Navigator.pushNamed(context, '/HomePage');
                  },
                  backgroundColor: kSecondaryColor,
                  buttonText: 'Go to home',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderFail(AuthProvider authData) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/failed.gif'),
          height: 120.0,
          width: 120.0,
        ),
        Text('Order Failed!'),
        SizedBox(
          height: 16.0,
        ),
        Image(
          image: NetworkImage(authData.userProfile["qr"] == null
              ? ''
              : authData.userProfile["qr"]),
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
                  buttonText: 'Continue Shopping',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SimpleRoundButton(
                  onPressed: () {
                    Future.delayed(Duration(seconds: 3));
                    Navigator.pushNamed(context, '/HomePage');
                  },
                  backgroundColor: kSecondaryColor,
                  buttonText: 'Go to home',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
