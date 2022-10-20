import 'dart:convert';
import 'package:http/http.dart' as http;

class Discount {
  final String id;

  Discount({
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const GET_ALL_DISCOUNTCODES = 'GET_ALL_DISCOUNTCODES';
  static const DELETE_DISCOUNTCODE = 'DELETE_DISCOUNTCODE';

  static Future<List<Discount>> getDiscountCodesFromDB() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_DISCOUNTCODES;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Discount> list = parseResponse(response.body);
        return list;
      } else {
        return <Discount>[];
      }
    } catch (e) {
      return <Discount>[];
    }
  }

  static Future<String> deleteDiscountCode(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_DISCOUNTCODE;
      map['id'] = id;
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

  static List<Discount> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Discount>((json) => Discount.fromJason(json)).toList();
  }

  factory Discount.fromJason(Map<String, dynamic> json) {
    return Discount(
      id: json["id"] as String,
    );
  }
}
