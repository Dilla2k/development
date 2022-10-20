import 'package:flutter/widgets.dart';

class PaymentNotifier with ChangeNotifier {
  int _paymentType = 1;

  int get paymentType => _paymentType;

  void setPaymentType(int paymentType) {
    _paymentType = paymentType;
    notifyListeners();
  }
}
