import 'drink_item.dart';
import '../Model/category.dart';
import '../Model/drink.dart';
import '../Utils/common.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final List<Drink> drinkList;
  final int tableNo;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.drinkList,
    required this.tableNo,
  }) : super(key: key);

  List<ListTile> _bildItems(List<Drink> drinkList) {
    var listTileList = <ListTile>[];
    for (Drink actualDrink
        in drinkList.where((element) => element.category == category.id)) {
      if (juiceProducts.contains(actualDrink.id)) {
        listTileList.add(ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          title: DrinkItem(
            tableNo: tableNo,
            drink: actualDrink,
            additionalDrinkList: drinkList
                .where((element) => element.category == Category.juice)
                .toList(),
          ),
        ));
      } else if (softDrinkProducts.contains(actualDrink.id)) {
        listTileList.add(
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: DrinkItem(
              tableNo: tableNo,
              drink: actualDrink,
              additionalDrinkList: drinkList
                  .where((element) => element.category == Category.softdrinks)
                  .toList(),
            ),
          ),
        );
      } else if (energyProducts.contains(actualDrink.id)) {
        listTileList.add(
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: DrinkItem(
              tableNo: tableNo,
              drink: actualDrink,
              additionalDrinkList: drinkList
                  .where((element) => element.category == Category.energy)
                  .toList(),
            ),
          ),
        );
      } else if (energyAndJuiceProducts.contains(actualDrink.id)) {
        listTileList.add(
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: DrinkItem(
              tableNo: tableNo,
              drink: actualDrink,
              additionalDrinkList: drinkList
                  .where((element) =>
                      element.category == Category.energy ||
                      element.category == Category.juice)
                  .toList(),
            ),
          ),
        );
      } else {
        listTileList.add(
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: DrinkItem(
              tableNo: tableNo,
              drink: actualDrink,
              additionalDrinkList: [],
            ),
          ),
        );
      }
    }
    return listTileList;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        title: Text(
          category.name!,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black.withOpacity(0.6),
        collapsedTextColor: Colors.white,
        collapsedBackgroundColor: Colors.black.withOpacity(0.7),
        children: _bildItems(drinkList));
  }
}
