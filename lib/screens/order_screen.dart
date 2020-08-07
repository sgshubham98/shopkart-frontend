import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopkart_frontend/providers/orders_provider.dart' show Orders;
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/order_item.dart';
import 'package:shopkart_frontend/widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        title: Text('Your Orders', style: TextStyle(color: kPrimaryColor),),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Expanded(child: Image.asset('assets/images/no_orders.png')),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
