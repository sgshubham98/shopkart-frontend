import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopkart_frontend/utilities/routes.dart' as api;
import 'package:shopkart_frontend/providers/cart_provider.dart';

class OrderItem {
  final String id;
  final num amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.http(api.BASE_URL, api.ADD_ORDER);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": authToken,
      },
    );
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<int> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.http(api.BASE_URL, api.ADD_ORDER);
    final timestamp = DateTime.now();
    var orderPost = json.encode({
      'amount': total,
      'dateTime': timestamp.toIso8601String(),
      // 'dateTime': timestamp,
      'products': cartProducts
          .map(
            (cp) => {
              'product': cp.id,
              'productName': cp.title,
              'quantity': cp.quantity,
              'price': cp.price,
              'discount': cp.discount,
            },
          )
          .toList(),
    });
    print('*****************************\n*******************************\n' +
        orderPost +
        '\n*****************************\n*******************************\n');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": authToken,
        },
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          // 'dateTime': timestamp,
          'products': cartProducts
              .map(
                (cp) => {
                  'product': cp.id,
                  'productName': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                  'discount': cp.discount,
                },
              )
              .toList(),
        }));
    // _orders.insert(
    //   0,
    //   OrderItem(
    //     id: timestamp.toIso8601String(),
    //     amount: total,
    //     dateTime: timestamp,
    //     products: cartProducts,
    //   ),
    // );
    notifyListeners();
    print('*****************************\n*******************************\n' +
        response.statusCode.toString() +
        '\n*****************************\n*******************************\n');

    return response.statusCode;
  }
}
