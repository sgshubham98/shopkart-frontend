import 'dart:convert';
import 'dart:io';
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
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  print(user);
  store.dispatch(GetUserAction(user));
};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
};

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

/* Bad code written: will change it later, it will work for the time being */
ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http
      .get('https://shopkart-inc.herokuapp.com/api/shop/viewall', headers: {
        'Content-Type': 'application/json',
    'x-auth-token':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoidXNlciIsImRhdGEiOnsiX2lkIjoiNWU5YWVhMmVjZDEwZGIwMDE3MGY3NWE2IiwibmFtZSI6IlJpdHdpY2sgQmhhcmdhdiIsImVtYWlsIjoicml0d2lja2JoYXJnYXY4MEBnbWFpbC5jb20iLCJjb250YWN0IjoiKzkxODIxODI5MDIzNiIsInJvbGUiOiJhZG1pbiIsInFyY29kZV91cmwiOiJodHRwOi8vcmVzLmNsb3VkaW5hcnkuY29tL3Nob3BrYXJ0L2ltYWdlL3VwbG9hZC92MTU4NzIxNjA0MC96M29tdzIycDZtemVldjhpYXNtcy5wbmcifSwiaWF0IjoxNTg3MzU5OTgzLCJleHAiOjE1ODc5NjQ3ODN9.VhZY2qz7GP4EbZBC6WqBbZuVMYWs3oV3k9lSPYS8S4M'
  });
  final responseData = json.decode(response.body);
  final List<dynamic> productsList = responseData['product'];
  List<Product> products = [];
  productsList.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<Product> _products;

  List<Product> get products => this._products;

  GetProductsAction(this._products);
}
