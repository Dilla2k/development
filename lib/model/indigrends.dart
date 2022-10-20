import 'dart:convert';
import 'package:http/http.dart' as http;

class Indigrends {
  final int id;
  final String name;
  final int category;
  final double price;

  Indigrends({
    this.id,
    this.name,
    this.category,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const GET_ALL_INDIGRENDS = 'GET_ALL_INDIGRENDS';
  static const GET_ALL_SAUCES = 'GET_ALL_SAUCES';

  static Future<List<Indigrends>> getIndigrendsFromDB() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_INDIGRENDS;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Indigrends> list = parseResponse(response.body);
        return list;
      } else {
        return <Indigrends>[];
      }
    } catch (e) {
      return <Indigrends>[];
    }
  }

  static Future<List<Indigrends>> getSaucesFromDB() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_SAUCES;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Indigrends> list = parseResponse(response.body);
        return list;
      } else {
        return <Indigrends>[];
      }
    } catch (e) {
      return <Indigrends>[];
    }
  }

  static List<Indigrends> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Indigrends>((json) => Indigrends.fromJason(json))
        .toList();
  }

  factory Indigrends.fromJason(Map<String, dynamic> json) {
    return Indigrends(
      id: int.parse(json["id"] as String),
      name: json["name"] as String,
      category: int.parse(json["category"] as String),
      price: double.parse(json["price"] as String),
    );
  }
}
