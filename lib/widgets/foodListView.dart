import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/notifier/category_notifier.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'foodItem.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({
    Key key,
    @required this.indigrendList,
    @required this.sauceList,
    @required this.foodList,
  }) : super(key: key);

  final List<Indigrends> indigrendList;
  final List<Indigrends> sauceList;
  final List<Food> foodList;

  @override
  _FoodListViewState createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  ItemScrollController controller;
  ItemPositionsListener positionListener;
  CategoryNotifier notifier;

  @override
  void initState() {
    super.initState();
    controller = ItemScrollController();
    positionListener = ItemPositionsListener.create();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier = Provider.of<CategoryNotifier>(context, listen: false);
      notifier.setfoodListController(controller);
      positionListener.itemPositions.addListener(() {
        int min;
        int max;
        if (positionListener.itemPositions.value.isNotEmpty) {
          // Determine the first visible item by finding the item with the
          // smallest trailing edge that is greater than 0.  i.e. the first
          // item whose trailing edge in visible in the viewport.
          min = positionListener.itemPositions.value
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
                  position.itemTrailingEdge < min.itemTrailingEdge
                      ? position
                      : min)
              .index;
          // Determine the last visible item by finding the item with the
          // greatest leading edge that is less than 1.  i.e. the last
          // item whose leading edge in visible in the viewport.
          max = positionListener.itemPositions.value
              .where((ItemPosition position) => position.itemLeadingEdge < 1)
              .reduce((ItemPosition max, ItemPosition position) =>
                  position.itemLeadingEdge > max.itemLeadingEdge
                      ? position
                      : max)
              .index;
        }
        if (min >= 1 && max <= 16) {
          notifier.setTopNavigationBarIndex(Food.DREHSPIESS);
          notifier.setFoodCategoryControllerOffset(
              Utils.DEHSPIESS_TOPBAR_SCROLLOFFSET);
        } else if (min >= 12 && max <= 43) {
          notifier.setTopNavigationBarIndex(Food.PIZZA);
          notifier
              .setFoodCategoryControllerOffset(Utils.PIZZA_TOPBAR_SCROLLOFFSET);
        } else if (min >= 38 && max <= 57) {
          notifier.setTopNavigationBarIndex(Food.PASTA);
          notifier
              .setFoodCategoryControllerOffset(Utils.PASTA_TOPBAR_SCROLLOFFSET);
        } else if (min >= 52 && max <= 66) {
          notifier.setTopNavigationBarIndex(Food.SCHNITZEL);
          notifier.setFoodCategoryControllerOffset(
              Utils.SCHNITZEL_TOPBAR_SCROLLOFFSET);
        } else if (min >= 59 && max <= 71) {
          notifier.setTopNavigationBarIndex(Food.SALAT);
          notifier
              .setFoodCategoryControllerOffset(Utils.SALAT_TOPBAR_SCROLLOFFSET);
        } /*else if (min >= 59 && max <= 69) {
          notifier.setTopNavigationBarIndex(Food.BURGER);
          notifier.setFoodCategoryControllerOffset(
              Utils.BURGER_TOPBAR_SCROLLOFFSET);
        } */
        else if (min >= 67 && max <= 84) {
          notifier.setTopNavigationBarIndex(Food.IMBISS);
          notifier.setFoodCategoryControllerOffset(
              Utils.IMBISS_TOPBAR_SCROLLOFFSET);
        } /* else if (min >= 59 && max <= 38) {
          notifier.setTopNavigationBarIndex(Food.SWEETS);
          notifier.setFoodCategoryControllerOffset(
              Utils.SWEETS_TOPBAR_SCROLLOFFSET);
        } */
        else if (min >= 74) {
          notifier.setTopNavigationBarIndex(Food.GETRAENKE);
          notifier.setFoodCategoryControllerOffset(
              Utils.GETRAENKE_TOPBAR_SCROLLOFFSET);
        }
      });

      switch (notifier.selectedCategory) {
        case Food.DREHSPIESS:
          controller.jumpTo(index: 1);
          break;
        case Food.PIZZA:
          controller.jumpTo(index: 14);
          break;
        case Food.PASTA:
          controller.jumpTo(index: 41);
          break;
        case Food.SCHNITZEL:
          controller.jumpTo(index: 55);
          break;
        case Food.SALAT:
          controller.jumpTo(index: 63);
          break;
        case Food.IMBISS:
          controller.jumpTo(index: 70);
          break;
        /*case Food.BURGER:
          controller.jumpTo(index: 62);
          break;
        case Food.SWEETS:
          controller.jumpTo(index: 50);
          break;*/
        case Food.GETRAENKE:
          controller.jumpTo(index: 81);
          break;
        default:
          controller.jumpTo(index: 1);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.separated(
      itemScrollController: controller,
      itemCount: widget.foodList.length + 1,
      itemPositionsListener: positionListener,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        if (index >= 0) {
          Food actualData = widget.foodList[index];
          switch (actualData.internalNumber) {
            case 1:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            case 21:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            case 51:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            case 71:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            case 81:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            /*case 90:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;*/
            case 100:
              return Utils.foodScreencategoryGroupList
                  .where((element) => element.index == actualData.category)
                  .first;
            case 200:
              if (actualData.id == 75) {
                return Utils.foodScreencategoryGroupList
                    .where((element) => element.index == actualData.category)
                    .first;
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        } else {
          return Container();
        }
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container();
        } else if (index > 0) {
          Food actualData = widget.foodList[index - 1];
          bool smallSize = false;
          if (actualData.priceSmall != 0.00) {
            smallSize = true;
          }
          return FoodItem(
            index: actualData.internalNumber,
            name: actualData.name,
            category: actualData.category,
            description: actualData.description,
            price: actualData.price,
            indigrends: widget.indigrendList,
            sauces: widget.sauceList,
            allergens: actualData.allergens,
            priceSmall: actualData.priceSmall,
            isSmall: smallSize,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
