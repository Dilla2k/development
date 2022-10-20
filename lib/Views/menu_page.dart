import '../Items/background_image.dart';

import '../Items/shoppingcart_floating_action_button.dart';
import 'drink_view.dart';
import 'shisha_view.dart';
import 'package:flutter/material.dart';
import '../Utils/common.dart';

class MenuPage extends StatelessWidget {
  static const String routeName = '/menuPage';
  final int tableNumber;

  const MenuPage({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: <Widget>[
          const BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                ShoppingCartFloatingActionButton(table: tableNumber),
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text("Shisha"),
                  ),
                  Tab(child: Text("Getränke")),
                ],
              ),
              backgroundColor: primaryColor,
              elevation: 0.0,
              titleSpacing: 10.0,
              centerTitle: true,
              title: Text(
                "Tisch " + tableNumber.toString(),
              ),
            ),
            body: TabBarView(
              physics: const ScrollPhysics(),
              children: [
                ShishaView(
                  tableNumber: tableNumber,
                ),
                DrinkView(
                  tableNumber: tableNumber,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
