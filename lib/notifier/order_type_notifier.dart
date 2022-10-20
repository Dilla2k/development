import 'package:flutter/widgets.dart';

class OrderTypeNotifier with ChangeNotifier {
  int _orderType = 1;
  String _orderTime = "";

  int get orderType => _orderType;

  void setOrderType(int orderType) {
    _orderType = orderType;
    notifyListeners();
  }

  String get orderTime => _orderTime;

  void setOrderTime(String orderTime) {
    _orderTime = orderTime;
    notifyListeners();
  }
}
