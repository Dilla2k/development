import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/widgets.dart';

class ChoosenSauceNotifier with ChangeNotifier {
  List<dynamic> _choosenSauce;
  FoodItem _foodItem;

  FoodItem get actualFoodItem => _foodItem;

  List<dynamic> get choosenSauce => _choosenSauce;

  void addChoosenSauce(List<dynamic> choosenSauce, FoodItem foodItem) {
    _choosenSauce = choosenSauce;
    _foodItem = foodItem;
    /*if (_choosenSauce == null) {
      _choosenSauce = choosenSauce;
       _foodItem = foodItem;
    } else {
      for (Indigrends sauce in _choosenSauce) {
        if (!_choosenSauce.contains(sauce)) {
          _choosenSauce.add(sauce);
        }
      }
    }*/
    notifyListeners();
  }

  void clear() {
    _choosenSauce = null;
    notifyListeners();
  }
}
