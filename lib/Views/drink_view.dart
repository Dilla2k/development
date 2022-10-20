import '../Items/category_item.dart';
import '../Model/category.dart';
import '../Model/drink.dart';
import 'package:flutter/material.dart';

class DrinkView extends StatefulWidget {
  final int? tableNumber;
  const DrinkView({Key? key, required this.tableNumber}) : super(key: key);

  @override
  State<DrinkView> createState() => _DrinkViewState();
}

class _DrinkViewState extends State<DrinkView> {
  late final Future? myFuture;
  List<Category>? categoryList = [];

  List<Drink>? drinkList = [];

  Future _getAllData() async {
    drinkList = await _getDrinks();
    return categoryList = await _getCategories();
  }

  Future _getCategories() async {
    return await Category.getCategories();
  }

  Future _getDrinks() async {
    return await Drink.getDrinks();
  }

  @override
  void initState() {
    myFuture = _getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if ((projectSnap.connectionState == ConnectionState.none) ||
            (projectSnap.connectionState == ConnectionState.waiting &&
                projectSnap.data == null)) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
            ),
          );
        } else if (((projectSnap.data) as List<Category>).isEmpty) {
          return const Center(
            child: Text(
              "Keine Kategorien vorhanden",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: categoryList!.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              Category actualCategory = categoryList![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryItem(
                    tableNo: widget.tableNumber!,
                    category: actualCategory,
                    drinkList: drinkList!),
              );
            },
          );
        }
      },
      future: myFuture,
    );
  }
}
