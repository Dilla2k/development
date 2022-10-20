import 'shoppingcart_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utils/common.dart';

class ShoppingItem extends StatefulWidget {
  final ShoppingCartItem shoppingCartItem;
  final int tableNo;
  final int index;

  const ShoppingItem(
      {Key? key,
      required this.shoppingCartItem,
      required this.tableNo,
      required this.index})
      : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            widget.shoppingCartItem.count.toString() + "x ",
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shoppingCartItem.productName,
                ),
                const SizedBox(
                  height: 1,
                ),
                widget.shoppingCartItem.productName.contains("Shisha")
                    ? Text(
                        widget.shoppingCartItem.additionalIndigrend!,
                        softWrap: true,
                        maxLines: 3,
                      )
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
          SizedBox(
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          context.read<ShoppingcartNotifier>().increaseCount(
                                widget.index,
                                widget.tableNo,
                              );
                        });
                      },
                      child: const Text("+"),
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor.withOpacity(0.8),
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        minimumSize: const Size(40, 40),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          context.read<ShoppingcartNotifier>().decreaseCount(
                                widget.index,
                                widget.tableNo,
                              );
                        });
                      },
                      child: const Text("-"),
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor.withOpacity(0.8),
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        minimumSize: const Size(40, 40),
                      ),
                    ),
                  ],
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
