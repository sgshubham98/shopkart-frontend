import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopkart_frontend/models/http_exception.dart';
import 'package:shopkart_frontend/utilities/routes.dart' as api;

class AuthProvider with ChangeNotifier {
  String _token;
  String _userId;
  String _phone;
  String _name;
  String _email;
  String _userQr;
  DateTime _expiryDate;

  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Map<String, dynamic> get userProfile {
    if (isAuth) {
      return {
        "name": _name,
        "phone": _phone,
        "email": _email,
        "qr": _userQr,
      };
    }
    return {};
  }

  Future<void> login(String phone, String password) async {
    final url = Uri.http(api.BASE_URL, api.LOGIN);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'mobile': phone,
          'password': password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['user']['_id'];
      _email = responseData['user']['email'];
      _name = responseData['user']['name'];
      _phone = responseData['user']['contact'];
      _userQr = responseData['user']['qrcode']['qrcode_url'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: 604800,
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
        'email': _email,
        'mobile': _phone,
        'name': _name,
        'qr': _userQr,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(
      String firstName,
      String lastName,
      String email,
      String mobile,
      String password,
      String confirmPassword,
      String role) async {
    final url = Uri.http(api.BASE_URL, api.REGISTER);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "contact": mobile,
          "password": password,
          "confirmPassword": confirmPassword,
          "role": role,
        }),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _userQr = extractedUserData['qr'];
    _name = extractedUserData['name'];
    _phone = extractedUserData['phone'];
    _email = extractedUserData['email'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _userQr = null;
    _phone = null;
    _name = null;
    _email = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
