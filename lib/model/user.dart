import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String id;
  final String name;
  final String firstName;
  final String street;
  final String postCode;
  final String city;
  final String email;
  final String phone;
  final String password;

  User(
      {this.name,
      this.firstName,
      this.street,
      this.postCode,
      this.city,
      this.email,
      this.phone,
      this.password,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'street': street,
      'postCode': postCode,
      'city': city,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const USER_REGISTRATION = 'REGISTRATION';
  static const USER_LOGIN = 'LOGIN';
  static const GET_USERID = 'GET_USERID_BY_EMAIL';
  static const EDIT_USER = 'EDIT_USER';
  static const GET_ISOPENED = 'GET_ISOPENED';
  static const SET_ISOPENED = 'SET_ISOPENED';

  static Future<String> makeRegistration(
      String userName,
      String userFirstName,
      String userStreet,
      String userPostCode,
      String userCity,
      String userEmail,
      String userPhone,
      String userPassword) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = USER_REGISTRATION;
      map['user_name'] = userName;
      map['user_firstname'] = userFirstName;
      map['user_street'] = userStreet;
      map['user_postcode'] = userPostCode;
      map['user_city'] = userCity;
      map['user_email'] = userEmail;
      map['user_phone'] = userPhone;
      map['user_password'] = userPassword;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        return "200";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<bool> login(String userEmail, String userPassword) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = USER_LOGIN;
      map['login_email'] = userEmail;
      map['login_password'] = userPassword;
      final response = await http.post(Uri.parse(ROOT), body: map);
      var message = jsonDecode(response.body);
      //print(message);
      if (message == 'Login Matched') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<User> getUserByEmail(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_USERID;
      map['email'] = email;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list[0];
      } else {
        return User();
      }
    } catch (e) {
      return User();
    }
  }

  static Future<String> closeStore(bool isOpened) async {
    try {
      String open = "0";
      var map = Map<String, dynamic>();
      map['action'] = SET_ISOPENED;
      if (isOpened) {
        open = "1";
      }
      map['isOpened'] = open;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        return "200";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static editUserItem(
    User user,
    String firstName,
    String name,
    String street,
    String postCode,
    String city,
    String email,
    String phone,
  ) async {
    var map = Map<String, dynamic>();
    map['action'] = EDIT_USER;
    map['id'] = user.id;
    map['firstName'] = firstName;
    map['name'] = name;
    map['street'] = street;
    map['postCode'] = postCode;
    map['city'] = city;
    map['email'] = email;
    map['phone'] = phone;
    await http.post(Uri.parse(ROOT), body: map);
  }

  static Future<bool> isStoreOpened() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ISOPENED;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        var parsed = json.decode(response.body.toString());
        String isOpened = parsed[0].values.toList()[0];
        if (isOpened == "1") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJason(json)).toList();
  }

  factory User.fromJason(Map<String, dynamic> json) {
    return User(
      id: json["id"] as String,
      name: json["name"] as String,
      firstName: json["firstName"] as String,
      street: json["street"] as String,
      postCode: json["postCode"] as String,
      city: json["city"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      password: json["password"] as String,
    );
  }
}
