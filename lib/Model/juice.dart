import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class Juice {
  int? id;
  String? name;

  Juice({
    this.id,
    this.name,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllJuiceAction = 'GET_ALL_JUICE';

  static Future<List<Juice>?> getJuice() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllJuiceAction;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Juice>? juiceList = parseResponse(response.body);
        return juiceList;
      } else {
        return <Juice>[];
      }
    } catch (e) {
      return <Juice>[];
    }
  }

  static List<Juice>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Juice>((json) => Juice.fromJason(json)).toList();
  }

  factory Juice.fromJason(Map<String, dynamic> json) {
    return Juice(
      id: json["id"] == null ? 0 : int.parse(json["id"] as String),
      name: json["name"] == null ? "" : json["name"] as String?,
    );
  }
}
