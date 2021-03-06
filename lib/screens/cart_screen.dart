import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart' show Cart;
import 'package:shopkart_frontend/screens/loading_screen.dart';
import 'package:shopkart_frontend/screens/order_status_screen.dart';
import 'package:shopkart_frontend/widgets/cart_item.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        // textTheme: TextTheme(),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Your Cart',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).clearCart();
            },
            child: Text('Clear Cart'),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _scanQR(),
              child: Container(
                height: 50,
                color: kSecondaryColor,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.qrcode),
                    Text(
                      " Scan Product",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.0,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => cart.totalAmount > 1
                  ? openCheckout(cart)
                  : Fluttertoast.showToast(
                      msg: "Alert: Cart total amount should be atleast RS.1",
                      timeInSecForIosWeb: 4,
                    ),
              child: Container(
                height: 50,
                color: kSecondaryColor,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Text(
                      " Place order",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: kPrimaryColor,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      // 'He',
                      '\u20b9${Provider.of<Cart>(context).totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: kSecondaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].discount,
                cart.items.values.toList()[i].manufacturer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openCheckout(Cart cart) async {
    double price = cart.totalAmount * 100;
    print(price);

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': price,
      'name': 'Order Payment',
      'description': 'This is the payment regarding your current order.',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.orderId);

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    Navigator.popUntil(
      context,
      ModalRoute.withName('/'),
    );
    // LoadingScreen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderStatus(true),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
    Navigator.popUntil(
      context,
      ModalRoute.withName('/'),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderStatus(false),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  Future _scanQR() async {
    final cart = Provider.of<Cart>(context, listen: false);
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      Map<String, dynamic> result = json.decode(qrResult.rawContent);
      setState(() {
        try {
          cart.addItem(result['_id'], result['price'] * 1.0, result['name'],
              result['discount'] * 1.0, result['manufacturer']);
        } on Exception catch (error) {
          Fluttertoast.showToast(
              msg: "Scanned QR is invalid!", timeInSecForIosWeb: 2);
          print(error);
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          Fluttertoast.showToast(
              msg: "Camera permission was denied", timeInSecForIosWeb: 2);
        });
      } else {
        setState(() {
          Fluttertoast.showToast(msg: "Unknown Error $ex");
        });
      }
    } on FormatException {
      setState(() {
        Fluttertoast.showToast(
            msg:
                "Either wrong Qr scanned or you pressed the back button before scanning anything",
            timeInSecForIosWeb: 2);
      });
    } catch (ex) {
      setState(() {
        Fluttertoast.showToast(msg: "Unknown Error $ex");
      });
    }
  }
}
