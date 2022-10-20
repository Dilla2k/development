import 'dart:convert';
import 'package:Aroma/model/food.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/shoppingCartItem.dart';
import 'package:http/http.dart' as http;

import 'indigrends.dart';

class Order {
  final String id;
  final String userId;
  final double price;
  final String date;
  final String foodItems;

  Order({
    this.id,
    this.userId,
    this.price,
    this.date,
    this.foodItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'price': price,
      'date': date,
      'foodItems': foodItems,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const GET_ORDER_BY_USERID = 'GET_ORDER_BY_USERID';
  static const SEND_MAIL = 'SEND_MAIL';
  static const SEND_MAIL_TO_RESTAURANT = 'SEND_MAIL_TO_RESTAURANT';
  static const MAKE_ORDER = 'MAKE_ORDER';
  static const MAKE_ORDER_FOODITEMS = "MAKE_ORDER_FOODITEMS";

  static Future<List<Order>> getOrdersByUserIdFromDB(String userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ORDER_BY_USERID;
      map['userId'] = userId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Order> list = parseResponse(response.body);
        return list;
      } else {
        return <Order>[];
      }
    } catch (e) {
      return <Order>[];
    }
  }

  static Future<String> sendMail(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SEND_MAIL;
      map['user_email'] = email;
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

  static Future<String> sendMailToRestaurant(String orderId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SEND_MAIL_TO_RESTAURANT;
      map['user_email'] = Utils.RESTAURANT_EMAIL;
      map['order_id'] = orderId;
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

  static List<Order> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Order>((json) => Order.fromJason(json)).toList();
  }

  factory Order.fromJason(Map<String, dynamic> json) {
    return Order(
      id: json["id"] as String,
      userId: json["userId"] as String,
      price: double.parse(json["price"] as String),
      date: json["date"] as String,
      foodItems: json["foodItems"] as String,
    );
  }

  static Future<String> makeOrder({
    String id,
    String userId,
    double price,
    String userName,
    String userFirstName,
    String userStreet,
    String userPostCode,
    String userCity,
    String userEmail,
    String userPhone,
    int orderType,
    String orderTime,
    String payed,
    List<ShoppingCartItem> foodItems,
  }) async {
    try {
      var orderMap = Map<String, dynamic>();
      var itemMap = Map<String, dynamic>();
      orderMap['action'] = MAKE_ORDER;
      orderMap['id'] = id;
      orderMap['userId'] = userId;
      orderMap['price'] = price.toString();
      orderMap['userName'] = userName;
      orderMap['userFirstName'] = userFirstName;
      orderMap['userStreet'] = userStreet;
      orderMap['userPostCode'] = userPostCode;
      orderMap['userCity'] = userCity;
      orderMap['userEmail'] = userEmail;
      orderMap['userPhone'] = userPhone;
      orderMap['orderType'] = orderType.toString();
      orderMap['orderTime'] = orderTime;
      orderMap['payed'] = payed;

      for (ShoppingCartItem actualItem in foodItems) {
        String annotation = "";
        String indigrends = "";
        if (actualItem.annotation != null) {
          annotation = actualItem.annotation;
        }
        if (actualItem.choosenIndigrends != null) {
          if (actualItem.choosenIndigrends.length != 0) {
            for (Indigrends actualIndigrend in actualItem.choosenIndigrends) {
              try {
                if (actualItem.choosenIndigrends.length > 1) {
                  indigrends += "mit " + actualIndigrend.name + "\n";
                } else {
                  if (actualIndigrend.name == "überbacken") {
                    indigrends = actualIndigrend.name;
                  } else {
                    indigrends = "mit " + actualIndigrend.name;
                  }
                }
              } catch (e) {
                print("Fehler1");
              }
            }
          }
        }
        try {
          itemMap['action'] = MAKE_ORDER_FOODITEMS;
          itemMap['orderId'] = id;
          if (actualItem.size != null) {
            itemMap['foodItem'] =
                actualItem.size + " " + actualItem.foodItem.name;
          } else {
            itemMap['foodItem'] = actualItem.foodItem.name;
          }
          itemMap['annotation'] = annotation;
          itemMap['quantity'] = actualItem.quantity.toString();
          itemMap['indigrends'] = indigrends;
          itemMap['price'] = Utils.calcFoodItemPrice(actualItem.quantity,
                  actualItem.foodItem, actualItem.choosenIndigrends)
              .toString();
          itemMap['categoryName'] =
              Food.getCategoryString(actualItem.foodItem.category);
          itemMap['foodIndex'] = actualItem.foodItem.index.toString();
          final itemResponse = await http.post(Uri.parse(ROOT), body: itemMap);
          if (200 == itemResponse.statusCode) {
            print("items succesful");
          } else {
            http.post(Uri.parse(ROOT), body: itemMap);
            print("items not succesful");
          }
        } catch (e) {
          print(e);
          print("Fehler2");
        }
      }

      final orderResponse = await http.post(Uri.parse(ROOT), body: orderMap);
      if (200 == orderResponse.statusCode) {
        print("Order succesful");
      } else {
        await http.post(Uri.parse(ROOT), body: orderMap);
        print("Order not succesful");
      }
    } catch (e) {
      print("Fehler3");
    }
  }
}
