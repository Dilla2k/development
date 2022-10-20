class User {
  static Future<bool> checkUserAcc(String user, String password) async {
    if (user == "barbossa" && password == "1234") {
      return true;
    } else {
      return false;
    }
  }
}
