import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/auth_providers.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart';
import 'package:shopkart_frontend/providers/shop_status_provider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/shopkart_logo_appbar.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';
import 'package:http/http.dart' as http;
import 'package:shopkart_frontend/utilities/routes.dart' as api;

class OrderStatus extends StatefulWidget {
  final orderStatus;

  OrderStatus(this.orderStatus);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  bool status;
  bool _isSubmitting;
  
  @override
  void initState() {
    super.initState();
     _orderSucess();
    // orderSuccessHoJaye();
  }

  // var response;

  // Future<void> orderSuccessHoJaye() async {
  //   final cart = Provider.of<Cart>(context, listen: false);
  //   response = await Provider.of<Orders>(context, listen: false).addOrder(
  //     cart.items.values.toList(),
  //     cart.totalAmount,
  //   );
  // }

  void _orderSucess() async {
  final cart = Provider.of<Cart>(context, listen: false);
  try {
  print(cart.totalAmount);
  print(cart.items.values.toList());
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          centerTitle: true,
          title: ShopkartLogoAppBar(),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: widget.orderStatus == true && status
                ? _orderSuccess(authData)
                : _orderFail(authData),
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
        // Text(response['message']),
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
        _isSubmitting == true
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xFF1BBC9B),
                    ),
                  )
                ],
              )
            : Row(
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
                          // Provider.of<ShopStatus>(context).checkStatus(authData);
                          // Future.delayed(Duration(seconds: 3));
                          final url = Uri.http(api.BASE_URL, api.SHOP_STATUS);
                          _checkStatus(url);
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
        _isSubmitting == true
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xFF1BBC9B),
                    ),
                  )
                ],
              )
            : Row(
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
                          final url = Uri.http(api.BASE_URL, api.SHOP_STATUS);
                          _checkStatus(url);
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

  void _checkStatus(url) async {
    setState(() {
      _isSubmitting = true;
    });
    final authData = Provider.of<AuthProvider>(context, listen: false);
    try {
      final response = await http.get(
        url,
        headers: {
          "x-auth-token": authData.token,
        },
      );
      if (response == null) {
        return;
      }
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Provider.of<ShopStatus>(context).changeStatus(responseData['inShop']);
        Fluttertoast.showToast(
            msg: responseData['message'], timeInSecForIosWeb: 3);
      } else {
        Fluttertoast.showToast(
            msg: responseData['message'], timeInSecForIosWeb: 2);
      }
      setState(() {
        _isSubmitting = false;
      });
    } catch (error) {
      throw (error);
    }
  }
}
