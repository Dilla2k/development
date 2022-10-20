import 'package:Aroma/notifier/category_notifier.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodScreenCategoryList extends StatefulWidget {
  final ValueChanged<int> parentAction;

  const FoodScreenCategoryList({Key key, this.parentAction}) : super(key: key);

  @override
  _FoodScreenCategoryListState createState() => _FoodScreenCategoryListState();
}

class _FoodScreenCategoryListState extends State<FoodScreenCategoryList> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier =
        Provider.of<CategoryNotifier>(context, listen: false);
    controller = categoryNotifier.foodCategoryController;
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        height: 75,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemCount: Utils.foodScreenCategoryList.length,
          itemBuilder: (context, index) {
            return Utils.foodScreenCategoryList[index];
          },
        ),
      ),
    );
  }
}
