import 'package:Aroma/widgets/foodItem.dart';
import 'package:Aroma/widgets/shoppingCartItem.dart';
import 'package:flutter/material.dart';

class CartNotifier with ChangeNotifier {
  List<ShoppingCartItem> _cart = [];
  List<dynamic> _choosenIndigrends = [];
  List<dynamic> _choosenSauce = [];
  int _quantity = 1;
  int _shoppingCartItemIndex;
  double _finalPrice = 0.0;
  bool _coupon = false;

  List<ShoppingCartItem> get cart => _cart;
  List<dynamic> get choosenIndigrends => _choosenIndigrends;
  List<dynamic> get choosenSauce => _choosenSauce;
  int get quantity => _quantity;
  int get shoppingCartItemIndex => _shoppingCartItemIndex;

  double get finalPrice => _finalPrice;

  set finalPrice(double finalPrice) {
    _finalPrice = finalPrice;
    //notifyListeners();
  }

  bool get coupon => _coupon;

  set coupon(bool coupon) {
    _coupon = coupon;
  }

  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void addToCart(index, int quantity, FoodItem food,
      List<dynamic> choosenIndigrends, List<dynamic> choosenSauce) {
    List<dynamic> indigrends = [];
    if (choosenIndigrends != null) {
      indigrends.addAll(choosenIndigrends);
    }

    if (choosenSauce != null) {
      indigrends.addAll(choosenSauce);
    }

    bool containsFoodItem = false;

    if (choosenIndigrends == null) {
      choosenIndigrends = [];
    }
    if (choosenSauce == null) {
      choosenSauce = [];
    }
    int index = 0;
    for (ShoppingCartItem value in _cart) {
      if (identical(value.foodItem.index, food.index) &&
          (identical(value.size, food.size)) &&
          (identical(value.choosenIndigrends, indigrends) ||
              (value.choosenIndigrends.length == 0 &&
                  indigrends.length == 0))) {
        containsFoodItem = true;
        _shoppingCartItemIndex = index;
        break;
      }
      index++;
    }
    if (containsFoodItem) {
      ShoppingCartItem cartItem = new ShoppingCartItem(
        foodItem: food,
        choosenIndigrends: choosenIndigrends + choosenSauce,
        quantity: _cart[_shoppingCartItemIndex].quantity + quantity,
        size: food.size,
        isSmall: food.isSmall,
      );
      _cart.removeAt(_shoppingCartItemIndex);
      _cart.add(cartItem);
      _choosenIndigrends = choosenIndigrends + choosenSauce;
    } else {
      ShoppingCartItem cartItem = new ShoppingCartItem(
        foodItem: food,
        choosenIndigrends: choosenIndigrends + choosenSauce,
        quantity: quantity,
        size: food.size,
        isSmall: food.isSmall,
      );
      _cart.add(cartItem);
      _choosenIndigrends = choosenIndigrends + choosenSauce;
    }

    notifyListeners();
  }

  void clear(ShoppingCartItem item) {
    if (_cart.contains(item)) {
      _cart.remove(item);
      notifyListeners();
    }
  }

  void clearAll() {
    _cart.clear();
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
