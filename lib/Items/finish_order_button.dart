import 'package:awesome_dialog/awesome_dialog.dart';
import '../Model/order.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/fade_route.dart';
import '../Views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FinishOrderButton extends StatelessWidget {
  final int tableNumber;
  const FinishOrderButton({Key? key, required this.tableNumber})
      : super(key: key);

  _finishOrder(BuildContext context) async {
    DateTime currentTimeStamp = DateTime.now();
    DateTime current = DateTime(currentTimeStamp.year, currentTimeStamp.month,
        currentTimeStamp.day, currentTimeStamp.hour, currentTimeStamp.minute);

    await Order.getOpenOrderByTable(tableNumber).then((value) {
      Order.updateOrder(
          value!.id!,
          tableNumber,
          current.toString(),
          value.price!,
          1,
          0,
          context
              .read<ShoppingcartNotifier>()
              .getShoppingCartFinishItemList(tableNumber)!);
    });
    context.read<ShoppingcartNotifier>().finish(tableNumber);
  }

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
            title: 'Tisch abschließen?',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              _finishOrder(context);
              Fluttertoast.showToast(
                  msg: "Tisch abgeschlossen",
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
        child: const Text("Tisch abschließen", textAlign: TextAlign.center),
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
