import 'dart:convert';
import 'package:http/http.dart' as http;

class Allergen {
  final String id;
  final String name;
  static List<Allergen> _allergenList;

  Allergen({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const GET_ALL_ALLEGENS = 'GET_ALL_ALLERGENS';

  static List<String> getAllergenList(String allergenString) {
    List<String> allergenList = allergenString.split(",");
    List<String> returnList = new List();
    _allergenList.forEach((element) {
      if (allergenList.contains(element.id)) {
        returnList.add(element.name);
      }
    });
    return returnList;
  }

  static getAllergensFromDB() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ALLEGENS;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Allergen> list = parseResponse(response.body);
        _allergenList = list;
      } else {
        _allergenList = <Allergen>[];
      }
    } catch (e) {
      _allergenList = <Allergen>[];
    }
  }

  static List<Allergen> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Allergen>((json) => Allergen.fromJason(json)).toList();
  }

  factory Allergen.fromJason(Map<String, dynamic> json) {
    return Allergen(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}
