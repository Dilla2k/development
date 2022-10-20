import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CategoryNotifier with ChangeNotifier {
  int _topNavigationBarIndex;
  double _controllerTopPosition = 0;
  int _controllerPosition = 1;
  ItemScrollController _foodListController;
  ScrollController _foodCategoryController;
  int _selectedCategory = 0;

  int get selectedCategory => _selectedCategory;
  int get topNavigationBarIndex => _topNavigationBarIndex;
  double get topNavigationBarOffset => _controllerTopPosition;
  ItemScrollController get foodListController => _foodListController;
  ScrollController get foodCategoryController {
    _foodCategoryController = ScrollController(
        initialScrollOffset: topNavigationBarOffset.toDouble());
    return _foodCategoryController;
  }

  void setControllerPosition(int controllerPosition) {
    _controllerPosition = controllerPosition;
    notifyListeners();
  }

  void setTopNavigationBarIndex(int index) {
    if (_topNavigationBarIndex != index) {
      _topNavigationBarIndex = index;
      notifyListeners();
    }
  }

  void setTopNavigationBarOffset(double offset) {
    _controllerTopPosition = offset;
    notifyListeners();
  }

  void setSelectedCategory(int selected) {
    _selectedCategory = selected;
    notifyListeners();
  }

  void setfoodListController(ItemScrollController scrollController) {
    _foodListController = scrollController;
    notifyListeners();
  }

  void setFoodCategoryControllerOffset(double offset) {
    if (offset != _foodCategoryController.offset) {
      _foodCategoryController.jumpTo(offset);
    }
  }
  void jumpToIndex(int index) {
    _foodListController.jumpTo(index: index);
  }
}
