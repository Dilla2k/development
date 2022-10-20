import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class Category {
  int? id;
  String? name;

  static const int longdrinks = 1;
  static const int cocktailsWithAlc = 2;
  static const int cocktailsWithoutAlc = 3;
  static const int softdrinks = 4;
  static const int juice = 5;
  static const int energy = 6;
  static const int iceTea = 7;
  static const int homemadeIceTea = 8;
  static const int milkshakes = 9;
  static const int shots = 10;
  static const int spirits = 11;
  static const int wine = 12;
  static const int bottles = 13;
  static const int aperitiv = 14;
  static const int beer = 15;
  static const int coffeeAndHot = 16;
  static const int tea = 17;
  static const int packages = 18;
  static const int food = 19;

  Category({
    this.id,
    this.name,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllCategoryAction = 'GET_ALL_CATEGORIES';

  static Future<List<Category>?> getCategories() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllCategoryAction;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Category>? categoryList = parseResponse(response.body);
        return categoryList;
      } else {
        return <Category>[];
      }
    } catch (e) {
      return <Category>[];
    }
  }

  static List<Category>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJason(json)).toList();
  }

  factory Category.fromJason(Map<String, dynamic> json) {
    return Category(
      id: json["id"] == null ? 0 : int.parse(json["id"] as String),
      name: json["name"] == null ? "" : json["name"] as String?,
    );
  }
}
