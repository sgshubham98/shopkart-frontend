import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopkart_frontend/models/product.dart';
import 'package:shopkart_frontend/utilities/routes.dart' as api;
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _products = [];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._products);

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.http(api.BASE_URL, api.VIEW_PRODUCTS);
    try {
      final response = await http.get(
        url,
        headers: {
          "x-auth-token": authToken,
        },
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return;
      }
      List<Map<String, dynamic>> extractedData = responseData["product"];
      final List<Product> loadedProducts = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedProducts.add(Product(
          id: extractedData[i]["_id"],
          name: extractedData[i]['name'],
          price: extractedData[i]['price'],
          discount: extractedData[i]['discount'],
          manufacturer: extractedData[i]['manufacturer'],
          // category: ,
          // expiryDate: ,
          // manufacturingDate: ,
          // imageUrl: prodData['imageUrl'],
        ));
      }
      _products = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
