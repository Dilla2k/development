import 'package:awesome_dialog/awesome_dialog.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Utils/common.dart';
import '../Items/shoppingcart_item.dart';

class ShishaView extends StatelessWidget {
  final int tableNumber;
  ShishaView({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

  TextEditingController shishaController = TextEditingController();

  _normalPressed(BuildContext context) {
    AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO_REVERSED,
            width: 550,
            headerAnimationLoop: false,
            btnOkText: "Hinzufügen",
            btnOkOnPress: () => _orderShisha(context, 0),
            body: _shishaDialog(0))
        .show();
  }

  _premiumPressed(BuildContext context) {
    AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO_REVERSED,
            width: 550,
            headerAnimationLoop: false,
            btnOkText: "Hinzufügen",
            btnOkOnPress: () => _orderShisha(context, 1),
            body: _shishaDialog(1))
        .show();
  }

  _orderShisha(BuildContext context, int type) {
    if (type == 0) {
      context.read<ShoppingcartNotifier>().addToCart(
          ShoppingCartItem(
              id: Utils.idGenerator(),
              count: 1,
              price: 10.00,
              productName: "Normale Shisha",
              additionalIndigrend: shishaController.text,
              size: 0),
          tableNumber);
      Fluttertoast.showToast(
          msg: "Hinzugefügt",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          webBgColor: "#003874",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      shishaController.clear();
    } else {
      context.read<ShoppingcartNotifier>().addToCart(
          ShoppingCartItem(
              id: Utils.idGenerator(),
              count: 1,
              price: 12.50,
              productName: "Premium Shisha",
              additionalIndigrend: shishaController.text,
              size: 0),
          tableNumber);
      Fluttertoast.showToast(
          msg: "Hinzugefügt",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          webBgColor: "#003874",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      shishaController.clear();
    }
  }

  Widget _shishaDialog(int type) {
    return Column(
      children: [
        type == 0
            ? const Text(
                "Normale Shisha",
                style: TextStyle(fontSize: 18),
              )
            : const Text(
                "Premium Shisha",
                style: TextStyle(fontSize: 18),
              ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: shishaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sorte angeben',
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _normalPressed(context),
              child: const Text("Normal"),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(230, 80),
                primary: primaryColor.withOpacity(0.8),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _premiumPressed(context),
              child: const Text("Premium"),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(230, 80),
                primary: primaryColor.withOpacity(0.8),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
