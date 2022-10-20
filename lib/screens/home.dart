import 'dart:async';
import 'package:Aroma/model/allergens.dart';
import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/notifier/food_notifier.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/utils/pushNotificationService.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/categoryList.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/shoppingCartFloatingActionButton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UserNotifier>(context, listen: false).autoLogin();
      Utils.isRestaurantOpened(context);

      FoodNotifier foodNotifier =
          Provider.of<FoodNotifier>(context, listen: false);
      foodNotifier.foodList = await _getFood();
      foodNotifier.indigrendList = await _getIndigrends();
      foodNotifier.sauceList = await _getSauces();
      foodNotifier.allergenList = await _getAllergens();

      timer = Timer.periodic(Duration(seconds: 30),
          (Timer t) => Utils.isRestaurantOpened(context));
    });
  }

  Future<List<Food>> _getFood() async {
    var result = await Food.getFoodFromDB();
    return result;
  }

  Future<List<Indigrends>> _getIndigrends() async {
    var result = await Indigrends.getIndigrendsFromDB();
    return result;
  }

  Future<List<Indigrends>> _getSauces() async {
    var result = await Indigrends.getSaucesFromDB();
    return result;
  }

  Future<List<Allergen>> _getAllergens() async {
    var result = await Allergen.getAllergensFromDB();
    return result;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AromaAppBar(
            sFkey: _scaffoldKey,
            hasHeader: true,
          ),
        ),
        body: CategoryList(),
        endDrawer: Menu(),
        floatingActionButton: ShoppingCartFloatingActionButton(),
      ),
    );
  }
}
