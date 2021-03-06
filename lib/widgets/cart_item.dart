import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:shopkart_frontend/providers/cart_provider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final num price;
  final num quantity;
  final String title;
  final num discount;
  final String manufacturer;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.discount,
    this.manufacturer,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?\nThis action will remove all the quantities of the item.',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(
                'Price: $price\nManufacturer: $manufacturer\nDiscount: $discount',
              ),
              scrollable: true,
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
              ],
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text('\u20b9$price'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title),
                      Text(
                          'Total: \u20b9${(price * Provider.of<Cart>(context).itemQuantity(productId)).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.remove_circle),
                        onTap: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeSingleItem(productId);
                        },
                      ),
                      Text(
                          '${Provider.of<Cart>(context).itemQuantity(productId)} x'),
                      GestureDetector(
                        child: Icon(Icons.add_circle),
                        onTap: () {
                          Provider.of<Cart>(context).addItem(
                              productId, price, title, discount, manufacturer);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
