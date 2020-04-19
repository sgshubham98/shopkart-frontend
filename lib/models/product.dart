import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String category;
  String price;
  String discount;
  String manufacturer;
  String expiryDate;
  String manufacturingDate;

  Product(
      {@required this.id,
      @required this.name,
      this.category,
      @required this.price,
      @required this.discount,
      @required this.manufacturer,
      this.expiryDate,
      this.manufacturingDate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      discount: json['discount'],
      manufacturer: json['manufacturer'],
      category: json['category'],
      expiryDate: json['expirationDate'],
      manufacturingDate: json['manufacturingDate']
    );
  }
}
