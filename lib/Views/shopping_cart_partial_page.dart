import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Items/background_image.dart';
import '../Items/finish_partial_button.dart';
import '../Items/shopping_partial_item.dart';
import '../Items/shoppingcart_item.dart';
import '../Items/shoppingcart_price_widget.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';

class ShoppingPartialCartPage extends StatelessWidget {
  static const String routeName = '/shoppingCartPartialPage';

  final int tableNumber;

  const ShoppingPartialCartPage({
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
                "Teilzahlung Tisch " + tableNumber.toString(),
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
                            .getPartialPaymentItemList(tableNumber)!
                            .length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          List<ShoppingCartItem> itemList = context
                              .read<ShoppingcartNotifier>()
                              .getPartialPaymentItemList(tableNumber)!;
                          return ShoppingCartPartialItem(
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
                                  .partialPaymentPrice
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
                      FinishPartialButton(
                        tableNumber: tableNumber,
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
