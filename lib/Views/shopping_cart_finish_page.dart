import '../Items/background_image.dart';
import '../Items/shoppingcart_price_widget.dart';
import '../Items/finish_order_button.dart';
import '../Items/partial_payment_button.dart';
import '../Items/shopping_finish_item.dart';
import '../Items/shoppingcart_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingFinishCartPage extends StatelessWidget {
  static const String routeName = '/shoppingCartFinishPage';

  final int tableNumber;

  const ShoppingFinishCartPage({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

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
                "Abschluss Tisch " + tableNumber.toString(),
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shoppingCartBackgroundColor.withOpacity(0.7),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 100.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.625,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .watch<ShoppingcartNotifier>()
                            .getShoppingCartFinishItemList(tableNumber)!
                            .length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          List<ShoppingCartItem> itemList = context
                              .watch<ShoppingcartNotifier>()
                              .getShoppingCartFinishItemList(tableNumber)!;
                          return ShoppingFinishItem(
                              shoppingCartItem: itemList[index],
                              tableNumber: tableNumber,
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
                                  .shoppingCartFinishPrice
                                  .toStringAsFixed(2) +
                              " €"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PartialPaymentButton(tableNumber: tableNumber),
                      FinishOrderButton(tableNumber: tableNumber),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
