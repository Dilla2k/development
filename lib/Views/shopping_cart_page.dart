import '../Items/background_image.dart';
import '../Items/shoppingcart_price_widget.dart';
import '../Items/shopping_item.dart';
import '../Items/shoppingcart_item.dart';
import '../Model/order.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/fade_route.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Utils/common.dart';

class ShoppingCartPage extends StatelessWidget {
  static const String routeName = '/shoppingCartPage';

  final int tableNumber;

  const ShoppingCartPage({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

  _makeOrder(BuildContext context) async {
    DateTime currentTimeStamp = DateTime.now();
    DateTime current = DateTime(currentTimeStamp.year, currentTimeStamp.month,
        currentTimeStamp.day, currentTimeStamp.hour, currentTimeStamp.minute);

    await Order.getOpenOrderByTable(tableNumber).then((value) {
      if (value == null) {
        Order.makeOrder(
            tableNumber,
            current.toString(),
            0,
            context.read<ShoppingcartNotifier>().shoppingCartPrice,
            context
                .read<ShoppingcartNotifier>()
                .getShoppingCartItemList(tableNumber)!);
      } else {
        double endPrice =
            context.read<ShoppingcartNotifier>().shoppingCartPrice +
                value.price!;
        List<ShoppingCartItem> itemList = context
            .read<ShoppingcartNotifier>()
            .getShoppingCartItemList(tableNumber)!
            .toList();
        Order.updateOrder(value.id!, tableNumber, current.toString(), endPrice,
            0, 0, itemList);
      }
    });

    for (ShoppingCartItem actualItem in context
        .read<ShoppingcartNotifier>()
        .getShoppingCartItemList(tableNumber)!) {
      context
          .read<ShoppingcartNotifier>()
          .addToFinishCart(actualItem, tableNumber);
    }
    context.read<ShoppingcartNotifier>().clear(tableNumber);
    Fluttertoast.showToast(
        msg: "Bestellung wird gedruckt",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "#003874",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0.0,
              titleSpacing: 10.0,
              centerTitle: true,
              title: Text(
                "Warenkorb Tisch " + tableNumber.toString(),
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 100.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.625,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .read<ShoppingcartNotifier>()
                            .getShoppingCartItemList(tableNumber)!
                            .length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          List<ShoppingCartItem> itemList = context
                              .read<ShoppingcartNotifier>()
                              .getShoppingCartItemList(tableNumber)!;
                          return ShoppingItem(
                              shoppingCartItem: itemList[index],
                              tableNo: tableNumber,
                              index: index);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ShoppingCartPriceWidget(
                          price: context
                                  .watch<ShoppingcartNotifier>()
                                  .shoppingCartPrice
                                  .toStringAsFixed(2) +
                              " €")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        height: 80,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                page: const HomePage(),
                              ),
                            );
                            _makeOrder(context);
                          },
                          child: const Text("Bestellung aufnehmen",
                              textAlign: TextAlign.center),
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor.withOpacity(0.8),
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
