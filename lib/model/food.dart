import 'dart:convert';
import 'package:http/http.dart' as http;

class Food {
  final int id;
  final String name;
  final String description;
  final int category;
  final double price;
  final int internalNumber;
  final int isPromoted;
  final Map<String, dynamic> subIngredients;
  final String allergens;
  final double priceSmall;

  static const int DREHSPIESS = 0;
  static const int PIZZA = 1;
  static const int PASTA = 2;
  static const int SCHNITZEL = 3;
  static const int SALAT = 4;
  //static const int BURGER = 5;
  static const int IMBISS = 5;
  //static const int IMBISS = 6;
  //static const int SWEETS = 7;
  static const int GETRAENKE = 6;
  //static const int GETRAENKE = 8;
  static const int PROMOTED = 20;

  Food({
    this.allergens,
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.internalNumber,
    this.isPromoted,
    this.subIngredients,
    this.priceSmall,
  });

  static String getCategoryString(int category) {
    switch (category) {
      case DREHSPIESS:
        return "Kebap & Gerolltes";
        break;
      case PIZZA:
        return "Pizza";
        break;
      case PASTA:
        return "Pasta";
        break;
      case SCHNITZEL:
        return "Schnitzel";
        break;
      case SALAT:
        return "Salat";
        break;
      case IMBISS:
        return "Imbiss";
        break;
      case GETRAENKE:
        return "Getränke";
        break;
      /*case BURGER:
        return "Burger";
        break;
      case SWEETS:
        return "Süßes & Saures";
        break;*/
      default:
        return "";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'subIngredients': subIngredients,
      'allergens': allergens,
    };
  }

  //TEST
  //static const ROOT = 'http://192.168.23.48/getData.php';
  //PROD with burger
  //static const ROOT = 'https://www.aroma-siegen.de/app/getData1.php';
  static const ROOT = 'https://www.aroma-siegen.de/app/getData.php';
  static const GET_ALL_FOOD = 'GET_ALL_FOOD';
  static const GET_ALL_INDIGRENDS = 'GET_ALL_INDIGRENDS';
  static const GET_ALL_ALLEGENS = 'GET_ALL_ALLERGENS';

  static Future<List<Food>> getFoodFromDB() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_FOOD;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (200 == response.statusCode) {
        List<Food> list = parseResponse(response.body);
        return list;
      } else {
        return <Food>[];
      }
    } catch (e) {
      return <Food>[];
    }
  }

  static List<Food> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => Food.fromJason(json)).toList();
  }

  factory Food.fromJason(Map<String, dynamic> json) {
    return Food(
      id: int.parse(json["id"] as String),
      name: json["name"] as String,
      category: int.parse(json["category"] as String),
      description: json["description"] as String,
      price: double.parse(json["price"] as String),
      internalNumber: int.parse(json["internalNumber"] as String),
      isPromoted: int.parse(json["isPromoted"] as String),
      allergens: json["allergens"] as String,
      priceSmall: double.parse(json["smallPrice"] as String),
    );
  }
}
