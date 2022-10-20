import 'package:flutter/widgets.dart';

class OpeningNotifier with ChangeNotifier {
  bool _isOpened = true;

  bool get isOpened => _isOpened;

  void setIsOpened(bool isOpened) {
    if (_isOpened != isOpened) {
      _isOpened = isOpened;
      notifyListeners();
    }
  }
}
