import 'dart:convert';

import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopkart_frontend/models/app_state.dart';
import 'package:shopkart_frontend/models/product.dart';
import 'package:shopkart_frontend/models/user.dart';
import 'package:http/http.dart' as http;

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user = storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  print(user);
  store.dispatch(GetUserAction(user));
};

class GetUserAction{
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http.get('https://shopkart-inc.herokuapp.com/api/shop/viewall');
  final responseData = json.decode(response.body);
  final List<dynamic> productsList = responseData['product'];
  List<Product> products = [];
  productsList.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction{
  final List<Product> _products;

  List<Product> get products => this._products;

  GetProductsAction(this._products);
}