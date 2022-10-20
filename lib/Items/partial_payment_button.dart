import '../Utils/fade_route.dart';
import '../Views/shopping_cart_partial_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Utils/common.dart';
import '../Provider/shoppingcart_notifier.dart';

class PartialPaymentButton extends StatelessWidget {
  final int tableNumber;
  const PartialPaymentButton({Key? key, required this.tableNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          context.read<ShoppingcartNotifier>().calcPartialPrice(tableNumber);
          if (context.read<ShoppingcartNotifier>().partialPaymentPrice == 0) {
            Fluttertoast.showToast(
                msg: "Keine Artikel zur Teilzahlung vorhanden",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                webBgColor: "#003874",
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Navigator.push(
              context,
              FadeRoute(
                page: ShoppingPartialCartPage(
                  tableNumber: tableNumber,
                ),
              ),
            );
          }
        },
        child: const Text("Teilzahlung", textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(240, 80),
          primary: primaryColor.withOpacity(0.8),
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
