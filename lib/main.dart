import 'package:Aroma/notifier/animation_notifier.dart';
import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/notifier/category_notifier.dart';
import 'package:Aroma/notifier/choosen_indigrends_notifier.dart';
import 'package:Aroma/notifier/choosen_sauce_notifier.dart';
import 'package:Aroma/notifier/food_notifier.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/notifier/order_type_notifier.dart';
import 'package:Aroma/notifier/payment_notifier.dart';
import 'package:Aroma/notifier/tabbar_change.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FoodNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderTypeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChoosenIndigrendsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChoosenSauceNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabBarChange(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => OpeningNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnimateNotifier(),
        ),
      ],
      child: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Home();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}
