import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class Energy {
  int? id;
  String? name;

  Energy({
    this.id,
    this.name,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllEnergyAction = 'GET_ALL_ENERGY';

  static Future<List<Energy>?> getDrinks() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllEnergyAction;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Energy>? energyList = parseResponse(response.body);
        return energyList;
      } else {
        return <Energy>[];
      }
    } catch (e) {
      return <Energy>[];
    }
  }

  static List<Energy>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Energy>((json) => Energy.fromJason(json)).toList();
  }

  factory Energy.fromJason(Map<String, dynamic> json) {
    return Energy(
      id: json["id"] == null ? 0 : int.parse(json["id"] as String),
      name: json["name"] == null ? "" : json["name"] as String?,
    );
  }
}
