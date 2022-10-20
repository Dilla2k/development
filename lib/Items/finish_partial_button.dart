import 'package:awesome_dialog/awesome_dialog.dart';
import 'shoppingcart_item.dart';
import '../Model/order_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/fade_route.dart';
import '../Views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FinishPartialButton extends StatelessWidget {
  final int tableNumber;
  const FinishPartialButton({Key? key, required this.tableNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.QUESTION,
            animType: AnimType.SCALE,
            headerAnimationLoop: false,
            btnCancelText: "Nein",
            btnOkText: "Ja",
            title: 'Teilzahlung abschließen?',
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              for (ShoppingCartItem item in context
                  .read<ShoppingcartNotifier>()
                  .getPartialPaymentItemList(tableNumber)!) {
                int count = item.count;
                try {
                  int tempCount = context
                      .read<ShoppingcartNotifier>()
                      .getShoppingCartFinishItemList(tableNumber)!
                      .where((element) => element.id == item.id)
                      .first
                      .count;
                  count = count + tempCount;
                } catch (e) {}
                OrderItem.updateOrderEntriesWithoutCount(
                    item.id!,
                    item.productName,
                    item.additionalIndigrend!,
                    item.price,
                    0,
                    0,
                    item.countPayed == null
                        ? 0 + item.count
                        : item.countPayed! + item.count);
              }
              context.read<ShoppingcartNotifier>().finishPartial(tableNumber);

              Fluttertoast.showToast(
                  msg: "Teilzahlung abgeschlossen",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  webBgColor: "#003874",
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(
                context,
                FadeRoute(
                  page: const HomePage(),
                ),
              );
            },
          ).show();
        },
        child:
            const Text("Teilzahlung abschließen", textAlign: TextAlign.center),
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
