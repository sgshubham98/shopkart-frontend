import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: status == true ? _orderSuccess() : _orderFail(),
        ),
      ),
    );
  }

  Widget _orderSuccess() {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/success.gif'),
          height: 150.0,
          width: 150.0,
        ),
      ],
    );
  }

  Widget _orderFail() {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/failed.gif'),
          height: 150.0,
          width: 150.0,
        ),
      ],
    );
  }
}