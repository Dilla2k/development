import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Model/category.dart';
import '../Model/drink.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/utils.dart';
import 'shoppingcart_item.dart';

class DrinkItem extends StatelessWidget {
  final Drink drink;
  final List<Drink> additionalDrinkList;
  final int tableNo;

  const DrinkItem(
      {Key? key,
      required this.drink,
      required this.additionalDrinkList,
      required this.tableNo})
      : super(key: key);

  _showToast() {
    Fluttertoast.showToast(
        msg: "Hinzugefügt",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "#003874",
        backgroundColor: Colors.red,
        textColor: drinkItemColor,
        fontSize: 16.0);
  }

  _pressed(
      {required Drink drink,
      required bool isBig,
      required BuildContext context,
      required double discount}) {
    if (productsWithAdditionalIndigrends.contains(drink.id)) {
      late AwesomeDialog dialog;
      dialog = AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.QUESTION,
        width: 550,
        headerAnimationLoop: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: GridView.builder(
              physics: const ScrollPhysics(),
              itemCount: additionalDrinkList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(125, 100),
                        primary: primaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        double price = 0.0;
                        int size = 0;
                        if (isBig) {
                          price = drink.bigPrice!;
                          size = 1;
                        } else {
                          price = drink.smallPrice!;
                        }
                        String drinkName = "";
                        if (isBig) {
                          drinkName = "gr. " + drink.name!;
                        } else {
                          if (drink.bigPrice != 0.00) {
                            drinkName = "kl. " + drink.name!;
                          } else {
                            drinkName = drink.name!;
                          }
                        }
                        double finalPrice = price;
                        if (discount >= 0) {
                          finalPrice = finalPrice - discount;
                        }
                        ShoppingCartItem shoppingCartItem = ShoppingCartItem(
                          id: Utils.idGenerator(),
                          count: 1,
                          price: finalPrice,
                          productName: drinkName,
                          size: size,
                          additionalIndigrend: additionalDrinkList[index].name!,
                          countPayed: 0,
                        );
                        context
                            .read<ShoppingcartNotifier>()
                            .addToCart(shoppingCartItem, tableNo);
                        dialog.dismiss();
                        _showToast();
                      },
                      child: Text(
                        additionalDrinkList[index].name!.substring(
                              0,
                              additionalDrinkList[index].name!.length - 5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      )..show();
    } else {
      double price = 0.0;
      int size = 0;
      if (isBig) {
        price = drink.bigPrice!;
        size = 1;
      } else {
        price = drink.smallPrice!;
      }
      String drinkName = "";
      if (drink.category == Category.wine) {
        if (isBig) {
          drinkName = "gr. " + drink.name!;
        } else {
          if (drink.bigPrice != 0.00) {
            drinkName = "kl. " + drink.name!;
          } else {
            drinkName = drink.name!;
          }
        }
      } else {
        if (isBig) {
          drinkName = drink.name! + " menu";
        } else {
          drinkName = drink.name!;
        }
      }

      ShoppingCartItem shoppingCartItem = ShoppingCartItem(
        id: Utils.idGenerator(),
        count: 1,
        price: price,
        productName: drinkName,
        size: size,
        additionalIndigrend: "",
        countPayed: 0,
      );

      context.read<ShoppingcartNotifier>().addToCart(shoppingCartItem, tableNo);
      _showToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            drink.name!,
            style: const TextStyle(
              color: drinkItemColor,
            ),
          ),
        ),
        Row(
          children: [
            singleSizeProducts.contains(drink.category) ||
                    (drink.bigPrice == 0.0)
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (discountProducts.contains(drink.id)) {
                            try {
                              final TextEditingController discountController =
                                  TextEditingController();
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.INFO_REVERSED,
                                width: 550,
                                headerAnimationLoop: false,
                                btnOkText: "Hinzufügen",
                                btnOkOnPress: () {
                                  if (discountController.text == "") {
                                    discountController.text = "0";
                                  }
                                  if (productsWithAdditionalIndigrends
                                      .contains(drink.id)) {
                                    _pressed(
                                        drink: drink,
                                        isBig: false,
                                        context: context,
                                        discount: double.parse(
                                            discountController.text));
                                  } else {
                                    if ((drink.smallPrice! -
                                            double.parse(
                                                discountController.text)) >=
                                        0) {
                                      ShoppingCartItem shoppingCartItem =
                                          ShoppingCartItem(
                                        id: Utils.idGenerator(),
                                        count: 1,
                                        price: drink.smallPrice! -
                                            double.parse(
                                                discountController.text),
                                        productName: drink.name!,
                                        size: 0,
                                        additionalIndigrend: "",
                                        countPayed: 0,
                                      );

                                      context
                                          .read<ShoppingcartNotifier>()
                                          .addToCart(shoppingCartItem, tableNo);

                                      _showToast();
                                    }
                                  }
                                },
                                body: Column(
                                  children: [
                                    const Text(
                                      "Rabatt",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          controller: discountController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Rabatt eingeben',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ).show();
                            } catch (e) {}
                          } else if (drink.category != Category.packages &&
                              drink.category != Category.bottles) {
                            ShoppingCartItem shoppingCartItem =
                                ShoppingCartItem(
                              id: Utils.idGenerator(),
                              count: 1,
                              price: drink.smallPrice!,
                              productName: drink.name!,
                              size: 0,
                              additionalIndigrend: "",
                              countPayed: 0,
                            );
                            context
                                .read<ShoppingcartNotifier>()
                                .addToCart(shoppingCartItem, tableNo);
                            _showToast();
                          } else {
                            _pressed(
                                drink: drink,
                                isBig: false,
                                context: context,
                                discount: 0);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          textStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        child: const Text("Hinzufügen"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        drink.smallPrice!.toStringAsFixed(2) + " €",
                        style: const TextStyle(
                          color: drinkItemColor,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      //Size small or normal
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _pressed(
                                  drink: drink,
                                  isBig: false,
                                  context: context,
                                  discount: 0),
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              child: drink.category == Category.food
                                  ? const Text("normal")
                                  : const Text("klein"),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              drink.smallPrice!.toStringAsFixed(2) + " €",
                              style: const TextStyle(
                                color: drinkItemColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Size Big or Menu
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _pressed(
                                  drink: drink,
                                  isBig: true,
                                  context: context,
                                  discount: 0),
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              child: drink.category == Category.food
                                  ? const Text("menu")
                                  : const Text("groß"),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              drink.bigPrice!.toStringAsFixed(2) + " €",
                              style: const TextStyle(
                                color: drinkItemColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        )
      ],
    );
  }
}
