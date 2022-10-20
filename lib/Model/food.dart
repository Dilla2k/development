import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class Food {
  int? id;
  String? name;
  double? normal;
  double? menu;

  Food({
    this.id,
    this.name,
    this.normal,
    this.menu,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllFoodAction = 'GET_ALL_FOOD';

  static Future<List<Food>?> getFood() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllFoodAction;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Food>? foodList = parseResponse(response.body);
        return foodList;
      } else {
        return <Food>[];
      }
    } catch (e) {
      return <Food>[];
    }
  }

  static List<Food>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => Food.fromJason(json)).toList();
  }

  factory Food.fromJason(Map<String, dynamic> json) {
    return Food(
      id: json["id"] == null ? 0 : int.parse(json["id"] as String),
      name: json["name"] == null ? "" : json["name"] as String?,
      normal: json["normal"] == null
          ? 0.00
          : double.parse(json["normal"] as String),
      menu: json["menu"] == null ? 0.00 : double.parse(json["menu"] as String),
    );
  }
}
