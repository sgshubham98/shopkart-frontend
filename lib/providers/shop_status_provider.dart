import 'package:flutter/material.dart';

class ShopStatus with ChangeNotifier {
  bool _status = false;

  bool get status {
    return _status;
  }

  void changeStatus(bool currStatus) {
    _status = currStatus;
    notifyListeners();
  }
}