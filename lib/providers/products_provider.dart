import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopkart_frontend/models/product.dart';

class Products with ChangeNotifier{
  List<Product> _products = [];

  List<Product> get products{
    return [..._products];
  }
}