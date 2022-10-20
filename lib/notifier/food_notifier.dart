import 'dart:collection';

import 'package:Aroma/model/allergens.dart';
import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  List<Indigrends> _indigrendList = [];
  List<Indigrends> _sauceList = [];
  List<Allergen> _allergenList = [];

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);
  UnmodifiableListView<Indigrends> get indigrendList =>
      UnmodifiableListView(_indigrendList);
  UnmodifiableListView<Indigrends> get sauceList =>
      UnmodifiableListView(_sauceList);
  UnmodifiableListView<Allergen> get allergenList =>
      UnmodifiableListView(_allergenList);

  set foodList(List<Food> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  set indigrendList(List<Indigrends> indigrendList) {
    _indigrendList = indigrendList;
    notifyListeners();
  }

  set sauceList(List<Indigrends> sauceList) {
    _sauceList = sauceList;
    notifyListeners();
  }

  set allergenList(List<Allergen> allergenList) {
    _allergenList = allergenList;
    notifyListeners();
  }
}
