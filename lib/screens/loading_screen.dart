import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart';
import 'package:shopkart_frontend/screens/order_status_screen.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    placeOrder();
  }

  void placeOrder() async {
    final cart = Provider.of<Cart>(context, listen: false);
    var response = await Provider.of<Orders>(context, listen: false).addOrder(
      cart.items.values.toList(),
      cart.totalAmount,
    );
    // if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OrderStatus(true);
          },
        ),
      );
    // } else {
    //    Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return OrderStatus(false);
    //       },
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitDoubleBounce(
          color: kSecondaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:shopkart_frontend/providers/cart_provider.dart';
// import 'package:shopkart_frontend/providers/orders_provider.dart';
// import 'package:shopkart_frontend/screens/order_status_screen.dart';
// import 'package:shopkart_frontend/utilities/constants.dart';

// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _orderSucess();
//   }

//   void _orderSucess() async {
//     final cart = Provider.of<Cart>(context, listen: false);
//     try {
//       print(cart.totalAmount);
//       int statusCode =
//           await Provider.of<Orders>(context, listen: false).addOrder(
//         cart.items.values.toList(),
//         cart.totalAmount,
//       );
//       if (statusCode == 200) {
//         cart.clearCart();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrderStatus(status: true),
//           ),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrderStatus(status: false),
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       Navigator.pushReplacementNamed(context, '/HomePage');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SpinKitDoubleBounce(
//             color: kSecondaryColor,
//             size: 50.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
