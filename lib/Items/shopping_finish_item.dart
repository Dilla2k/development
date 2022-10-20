import 'shoppingcart_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utils/common.dart';

class ShoppingFinishItem extends StatefulWidget {
  final ShoppingCartItem shoppingCartItem;
  final int tableNumber;
  final int index;

  const ShoppingFinishItem(
      {Key? key,
      required this.shoppingCartItem,
      required this.tableNumber,
      required this.index})
      : super(key: key);

  @override
  State<ShoppingFinishItem> createState() => _ShoppingFinishItemState();
}

class _ShoppingFinishItemState extends State<ShoppingFinishItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(widget.shoppingCartItem.count.toString() + "x"),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.shoppingCartItem.productName),
                const SizedBox(
                  height: 1,
                ),
                widget.shoppingCartItem.productName.contains("Shisha")
                    ? Text(widget.shoppingCartItem.additionalIndigrend!)
                    : widget.shoppingCartItem.additionalIndigrend != ""
                        ? Text(
                            widget.shoppingCartItem.additionalIndigrend!
                                .substring(
                              0,
                              widget.shoppingCartItem.additionalIndigrend!
                                      .length -
                                  5,
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ShoppingCartItem item = ShoppingCartItem(
                          id: widget.shoppingCartItem.id,
                          count: 1,
                          productName: widget.shoppingCartItem.productName,
                          price: widget.shoppingCartItem.price,
                          additionalIndigrend:
                              widget.shoppingCartItem.additionalIndigrend,
                          countPayed: widget.shoppingCartItem.countPayed,
                        );
                        context
                            .read<ShoppingcartNotifier>()
                            .addToPartialCart(item, widget.tableNumber);

                        context
                            .read<ShoppingcartNotifier>()
                            .decreaseFinishCount(
                                widget.index, widget.tableNumber);
                      });
                    },
                    child: const Icon(Icons.payment_outlined),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor.withOpacity(0.8),
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  ((widget.shoppingCartItem.price) *
                              (widget.shoppingCartItem.count))
                          .toStringAsFixed(2) +
                      " €",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
