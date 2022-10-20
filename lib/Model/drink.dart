import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Utils/common.dart';

class Drink {
  int? id;
  String? name;
  double? smallPrice;
  double? bigPrice;
  int? category;

  Drink({
    this.id,
    this.name,
    this.smallPrice,
    this.bigPrice,
    this.category,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllDrinksAction = 'GET_ALL_DRINKS';

  static Future<List<Drink>?> getDrinks() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllDrinksAction;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Drink>? drinkList = parseResponse(response.body);
        return drinkList;
      } else {
        return <Drink>[];
      }
    } catch (e) {
      return <Drink>[];
    }
  }

  static List<Drink>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Drink>((json) => Drink.fromJason(json)).toList();
  }

  factory Drink.fromJason(Map<String, dynamic> json) {
    return Drink(
      id: json["id"] == null ? 0 : int.parse(json["id"] as String),
      name: json["name"] == null ? "" : json["name"] as String?,
      smallPrice: json["smallPrice"] == null
          ? 0.00
          : double.parse(json["smallPrice"] as String),
      bigPrice: json["bigPrice"] == null
          ? 0.00
          : double.parse(json["bigPrice"] as String),
      category:
          json["category"] == null ? 0 : int.parse(json["category"] as String),
    );
  }
}
