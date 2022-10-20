import 'package:Aroma/model/user.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userId = "";
  String _discountCode = "";

  String get discountCode => _discountCode;

  void setdiscountCode(String value) {
    _discountCode = value;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('userEmail');
    final String userId = prefs.getString('userId');
    if (userEmail != null) {
      setIsLoggedIn(true);
      setUserId(userId);
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = "";
    prefs.remove('userId');
    prefs.remove('userEmail');
    setIsLoggedIn(false);
  }

  void setPrefs(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await User.getUserByEmail(userEmail).then((value) {
      prefs.setString('userId', value.id);
      prefs.setString('userEmail', value.email);
      autoLogin();
    });
  }
}
