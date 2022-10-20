import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/widgets.dart';

class ChoosenIndigrendsNotifier with ChangeNotifier {
  List<dynamic> _choosenIndigrends;
  FoodItem _foodItem;

  FoodItem get actualFoodItem => _foodItem;

  List<dynamic> get choosenIndigrends => _choosenIndigrends;

  void addChoosenIndigrends(
      List<dynamic> choosenIndigrends, FoodItem foodItem) {
    _choosenIndigrends = choosenIndigrends;
    _foodItem = foodItem;
    notifyListeners();
  }

  void removeIndigrend(int choosenIndigrendId, FoodItem foodItem) {
    if (_foodItem == foodItem) {
      _choosenIndigrends
          .removeWhere((element) => element == choosenIndigrendId);
    }
  }

  void clear() {
    _choosenIndigrends = null;
    notifyListeners();
  }
}
