import 'package:flutter/material.dart';

import '../Items/shoppingcart_item.dart';

class ShoppingcartNotifier with ChangeNotifier {
  final Map<int, List<ShoppingCartItem>> _shoppingCartItemList =
      <int, List<ShoppingCartItem>>{};

  final Map<int, List<ShoppingCartItem>> _shoppingCartFinishItemList =
      <int, List<ShoppingCartItem>>{};

  final Map<int, List<ShoppingCartItem>> _partialPaymentItemList =
      <int, List<ShoppingCartItem>>{};

  double _shoppingCartPrice = 0.0;
  double _shoppingCartFinishPrice = 0.0;
  double _partialPaymentPrice = 0.0;

  double get shoppingCartPrice => _shoppingCartPrice;

  set shoppingCartPrice(double shoppingCartPrice) {
    _shoppingCartPrice = shoppingCartPrice;
    notifyListeners();
  }

  double get shoppingCartFinishPrice => _shoppingCartFinishPrice;

  set shoppingCartFinishPrice(double shoppingCartFinishPrice) {
    _shoppingCartFinishPrice = shoppingCartFinishPrice;
    notifyListeners();
  }

  List<ShoppingCartItem>? getShoppingCartItemList(int table) {
    return _shoppingCartItemList[table];
  }

  setShoppingCartItemList(
      List<ShoppingCartItem> shoppingCartItemList, int table) {
    _shoppingCartItemList[table] = shoppingCartItemList;
    notifyListeners();
  }

  calcPrice(int table) {
    double tempPrice = 0.0;
    if (_shoppingCartItemList[table] != null) {
      for (ShoppingCartItem actualItem in _shoppingCartItemList[table]!) {
        tempPrice += actualItem.count * actualItem.price;
      }
    }
    shoppingCartPrice = tempPrice;
  }

  addToCart(ShoppingCartItem item, int table) {
    bool containsFoodItem = false;
    if (_shoppingCartItemList[table] == null) {
      _shoppingCartItemList[table] = <ShoppingCartItem>[];
    }
    if (_shoppingCartItemList[table]!.isNotEmpty) {
      for (ShoppingCartItem actualItem in _shoppingCartItemList[table]!) {
        if (actualItem.productName == item.productName) {
          if (actualItem.additionalIndigrend == item.additionalIndigrend) {
            if (actualItem.size == item.size) {
              _shoppingCartItemList[table]![
                      _shoppingCartItemList[table]!.indexOf(actualItem)]
                  .count++;
              containsFoodItem = true;
            }
          }
        }
      }
    }
    if (!containsFoodItem) {
      _shoppingCartItemList[table]!.add(item);
    }
    calcPrice(table);
    notifyListeners();
  }

  double get partialPaymentPrice => _partialPaymentPrice;

  set patialPaymentPrice(double partialPaymentPrice) {
    _partialPaymentPrice = partialPaymentPrice;
    notifyListeners();
  }

  List<ShoppingCartItem>? getPartialPaymentItemList(int table) {
    return _partialPaymentItemList[table];
  }

  setPartialPaymentItemList(
      List<ShoppingCartItem> partialPaymentItemList, int table) {
    _partialPaymentItemList[table] = partialPaymentItemList;
    calcPartialPrice(table);
    notifyListeners();
  }

  calcPartialPrice(int table) {
    double tempPrice = 0.0;
    if (_partialPaymentItemList[table] != null) {
      for (ShoppingCartItem actualItem in _partialPaymentItemList[table]!) {
        tempPrice += actualItem.count * actualItem.price;
      }
    }
    _partialPaymentPrice = tempPrice;
  }

  addToPartialCart(ShoppingCartItem item, int table) {
    bool containsFoodItem = false;
    if (_partialPaymentItemList[table] == null) {
      _partialPaymentItemList[table] = <ShoppingCartItem>[];
    }
    if (_partialPaymentItemList[table]!.isNotEmpty) {
      for (ShoppingCartItem actualItem in _partialPaymentItemList[table]!) {
        if (identical(actualItem.productName, item.productName)) {
          if (identical(
              actualItem.additionalIndigrend, item.additionalIndigrend)) {
            if (actualItem.size == item.size) {
              _partialPaymentItemList[table]![
                      _partialPaymentItemList[table]!.indexOf(actualItem)]
                  .count++;
              containsFoodItem = true;
            }
          }
        }
      }
    }
    if (!containsFoodItem) {
      _partialPaymentItemList[table]!.add(item);
    }
    calcPartialPrice(table);
    notifyListeners();
  }

  List<ShoppingCartItem>? getShoppingCartFinishItemList(int table) {
    return _shoppingCartFinishItemList[table];
  }

  setShoppingCartFinishItemList(
      List<ShoppingCartItem> shoppingCartFinishItemList, int table) {
    _shoppingCartFinishItemList[table] = shoppingCartFinishItemList;
    calcFinishPrice(table);
    notifyListeners();
  }

  calcFinishPrice(int table) {
    double tempPrice = 0.0;
    if (_shoppingCartFinishItemList[table] != null) {
      for (ShoppingCartItem actualItem in _shoppingCartFinishItemList[table]!) {
        tempPrice += actualItem.count * actualItem.price;
      }
    }
    shoppingCartFinishPrice = tempPrice;
  }

  addToFinishCart(ShoppingCartItem item, int table) {
    bool containsFoodItem = false;
    if (_shoppingCartFinishItemList[table] == null) {
      _shoppingCartFinishItemList[table] = <ShoppingCartItem>[];
    }
    if (_shoppingCartFinishItemList[table]!.isNotEmpty) {
      for (ShoppingCartItem actualItem in _shoppingCartFinishItemList[table]!) {
        if (identical(actualItem.productName, item.productName)) {
          if (identical(
              actualItem.additionalIndigrend, item.additionalIndigrend)) {
            if (actualItem.size == item.size) {
              if (item.count > 1) {
                _shoppingCartFinishItemList[table]![
                        _shoppingCartFinishItemList[table]!.indexOf(actualItem)]
                    .count = actualItem.count + item.count;
                containsFoodItem = true;
              } else {
                _shoppingCartFinishItemList[table]![
                        _shoppingCartFinishItemList[table]!.indexOf(actualItem)]
                    .count++;
                containsFoodItem = true;
              }
            }
          }
        }
      }
    }
    if (!containsFoodItem) {
      _shoppingCartFinishItemList[table]!.add(item);
    }
    calcFinishPrice(table);
    notifyListeners();
  }

  decreaseFinishCount(int index, int table) {
    if (_shoppingCartFinishItemList[table]![index].count == 1) {
      removeFromFinishCart(_shoppingCartFinishItemList[table]![index], table);
    } else {
      _shoppingCartFinishItemList[table]![index].count--;
    }

    calcFinishPrice(table);
    notifyListeners();
  }

  increaseCount(int index, int table) {
    _shoppingCartItemList[table]![index].count++;
    calcPrice(table);
    notifyListeners();
  }

  decreaseCount(int index, int table) {
    if (_shoppingCartItemList[table]![index].count == 1) {
      removeFromCart(_shoppingCartItemList[table]![index], table);
    } else {
      _shoppingCartItemList[table]![index].count--;
    }

    calcPrice(table);
    notifyListeners();
  }

  increasePartialCount(int index, int table) {
    if (_partialPaymentItemList[table]![index].count <
        _shoppingCartFinishItemList[table]![index].count) {
      _partialPaymentItemList[table]![index].count++;
      calcPartialPrice(table);
      notifyListeners();
    }
  }

  decreasePartialCount(int index, int table) {
    if (_partialPaymentItemList[table]![index].count == 1) {
      removeFromPartialCart(_partialPaymentItemList[table]![index], table);
    } else {
      _partialPaymentItemList[table]![index].count--;
    }

    calcPartialPrice(table);
    notifyListeners();
  }

  removeFromCart(ShoppingCartItem item, int table) {
    _shoppingCartItemList[table]!.remove(item);
    calcPrice(table);
    notifyListeners();
  }

  removeFromFinishCart(ShoppingCartItem item, int table) {
    _shoppingCartFinishItemList[table]!.remove(item);
    calcFinishPrice(table);
    notifyListeners();
  }

  removeFromPartialCart(ShoppingCartItem item, int table) {
    _partialPaymentItemList[table]!.remove(item);
    calcPartialPrice(table);
    notifyListeners();
  }

  void clear(int table) {
    _shoppingCartItemList[table]!.clear();
    calcPrice(table);
    notifyListeners();
  }

  void clearPartial(int table) {
    _partialPaymentItemList[table]!.clear();
    calcPartialPrice(table);
    notifyListeners();
  }

  void finish(int table) {
    _shoppingCartFinishItemList[table]!.clear();
    notifyListeners();
  }

  void finishPartial(int table) {
    _partialPaymentItemList[table]!.clear();
    notifyListeners();
  }
}
