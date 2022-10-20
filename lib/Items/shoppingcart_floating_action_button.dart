import '../Provider/shoppingcart_notifier.dart';
import '../Utils/fade_route.dart';
import '../Views/shopping_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ShoppingCartFloatingActionButton extends StatefulWidget {
  final int table;
  const ShoppingCartFloatingActionButton({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  State<ShoppingCartFloatingActionButton> createState() =>
      _ShoppingCartFloatingActionButtonState();
}

class _ShoppingCartFloatingActionButtonState
    extends State<ShoppingCartFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      width: 90.0,
      child: FittedBox(
        child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Warenkorb",
                    style: TextStyle(fontSize: 6),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    context
                        .watch<ShoppingcartNotifier>()
                        .shoppingCartPrice
                        .toStringAsFixed(2),
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            onPressed: () {
              if (context.read<ShoppingcartNotifier>().shoppingCartPrice != 0) {
                Navigator.push(
                  context,
                  FadeRoute(
                    page: ShoppingCartPage(
                      tableNumber: widget.table,
                    ),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                    msg: "Keine Artikel im Warenkorb",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    webBgColor: "#003874",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }),
      ),
    );
  }
}
