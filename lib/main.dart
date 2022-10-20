import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/shoppingcart_notifier.dart';
import 'Utils/routes.dart';
import 'Views/home_page.dart';
import 'Views/login_page.dart';
import 'Views/menu_page.dart';
import 'Views/shopping_cart_finish_page.dart';
import 'Views/shopping_cart_page.dart';
import 'Views/shopping_cart_partial_page.dart';
import 'Views/table_finish_page.dart';
import 'Views/table_order_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ShoppingcartNotifier(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barbossa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.shoppingCart: (context) => const ShoppingCartPage(
              tableNumber: 0,
            ),
        Routes.menu: (context) => const MenuPage(tableNumber: 0),
        Routes.login: (context) => const LoginPage(),
        Routes.tableOrder: (context) => const TableOrderPage(),
        Routes.tableFinish: (context) => const TableFinishPage(),
        Routes.shoppingCartPartial: (context) => const ShoppingPartialCartPage(
              tableNumber: 0,
            ),
        Routes.shoppingFinishCart: (context) => const ShoppingFinishCartPage(
              tableNumber: 0,
            ),
      },
    );
  }
}
