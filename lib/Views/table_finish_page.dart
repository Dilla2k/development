import 'package:awesome_dialog/awesome_dialog.dart';
import '../Items/background_image.dart';
import '../Model/order.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/fade_route.dart';
import 'shopping_cart_finish_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TableFinishPage extends StatelessWidget {
  static const String routeName = '/tableFinishPage';
  const TableFinishPage({Key? key}) : super(key: key);

  Color _getColor(int table, BuildContext context) {
    if (context
            .read<ShoppingcartNotifier>()
            .getShoppingCartFinishItemList(table + 1) ==
        null) {
      return primaryColor.withOpacity(0.8);
      ;
    } else {
      if (context
          .read<ShoppingcartNotifier>()
          .getShoppingCartFinishItemList(table + 1)!
          .isNotEmpty) {
        return Colors.redAccent.withOpacity(0.8);
      } else {
        return primaryColor.withOpacity(0.8);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0.0,
            titleSpacing: 10.0,
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: tableNo,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _getColor(index, context),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<ShoppingcartNotifier>()
                                .calcFinishPrice(index + 1);
                            if (context
                                    .read<ShoppingcartNotifier>()
                                    .shoppingCartFinishPrice ==
                                0) {
                              Fluttertoast.showToast(
                                  msg: "Warenkorb ist leer",
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
                                  page: ShoppingFinishCartPage(
                                    tableNumber: index + 1,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Tisch " + (index + 1).toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      animType: AnimType.SCALE,
                      headerAnimationLoop: false,
                      btnCancelText: "Nein",
                      btnOkText: "Ja",
                      title: 'Auswertung drucken?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        Order.makeOrder(
                          100,
                          "0000-00-00 00:00:00",
                          3,
                          0.00,
                          [],
                        );
                        Fluttertoast.showToast(
                            msg: "Auswertung wird gedruckt",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            webBgColor: "#003874",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    ).show();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Auswertung", textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
