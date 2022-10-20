import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/notifier/food_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/FoodScreenCategoryList.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/foodListView.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/shoppingCartFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({Key key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  ItemScrollController controller = ItemScrollController();

  List<Indigrends> _indigrendList = <Indigrends>[];
  List<Food> _foodList = <Food>[];
  List<Indigrends> _sauceList = <Indigrends>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isOpened = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _dataBody() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);

    _foodList = foodNotifier.foodList;
    _indigrendList = foodNotifier.indigrendList;
    _sauceList = foodNotifier.sauceList;

    return Container(
      child: FoodListView(
        indigrendList: _indigrendList,
        sauceList: _sauceList,
        foodList: _foodList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AromaAppBar(
          sFkey: _scaffoldKey,
          hasHeader: true,
        ),
      ),
      endDrawer: Menu(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FoodScreenCategoryList(),
            SizedBox(
              height: 10,
            ),
            Container(
              child: _dataBody(),
              height: MediaQuery.of(context).size.height * 0.75,
            ),
          ],
        ),
      ),
      floatingActionButton: ShoppingCartFloatingActionButton(),
    );
  }
}
