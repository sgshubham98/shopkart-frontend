import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String name;
  String category;
  num price;
  num discount;
  String manufacturer;
  String expiryDate;
  String manufacturingDate;

  Product({
    @required this.id,
    @required this.name,
    this.category,
    this.expiryDate,
    @required this.price,
    @required this.manufacturer,
    this.manufacturingDate,
    @required this.discount
  });
}
