import '../Provider/shoppingcart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartPriceWidget extends StatefulWidget {
  final String price;
  ShoppingCartPriceWidget({Key? key, required this.price}) : super(key: key);

  @override
  State<ShoppingCartPriceWidget> createState() =>
      _ShoppingCartPriceWidgetState();
}

class _ShoppingCartPriceWidgetState extends State<ShoppingCartPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Gesamt",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
