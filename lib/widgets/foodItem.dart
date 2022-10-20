import 'dart:ui';
import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/notifier/animation_notifier.dart';
import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/notifier/choosen_indigrends_notifier.dart';
import 'package:Aroma/notifier/choosen_sauce_notifier.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/MultiSelectIndigrends/indigrendsMultiSelect.dart';
import 'package:Aroma/widgets/customDropDown.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MultiSelectIndigrends/sauceMultiSelect.dart';
import 'MultiSelectIndigrends/sauceMultiSelectFree.dart';
import 'MultiSelectIndigrends/sauceSingleSelect.dart';
import 'foodItemAllergensButton.dart';
import 'package:smart_select/smart_select.dart';

// ignore: must_be_immutable
class FoodItem extends StatefulWidget {
  final int index;
  final String name;
  final String description;
  final int category;
  final double price;
  final List<Indigrends> indigrends;
  final List<Indigrends> sauces;
  List<Indigrends> choosenIndigrends;
  final bool isExpanded;
  final indigrendsExpanded;
  final String allergens;
  final double priceSmall;
  bool isSmall;
  String size;

  FoodItem({
    this.name,
    this.description,
    this.category,
    this.price,
    this.index,
    this.isExpanded,
    this.indigrends,
    this.indigrendsExpanded,
    this.sauces,
    this.allergens,
    this.priceSmall,
    this.isSmall,
    this.size,
  });

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool isItemExpanded = false;
  bool isIndigrendsExpanded = false;
  Color color = Colors.white;
  int _n = 1;
  bool _isChecked = false;
  bool _isCheckedMeat = false;
  bool _isCheckedBurger = false;
  final formKey = new UniqueKey();
  final saucekey = new UniqueKey();
  final indigrendKey = new UniqueKey();
  final extraMeatKey = new UniqueKey();
  final extraCheeseKey = new UniqueKey();
  List<S2Choice<String>> imbissBox = [
    S2Choice<String>(value: '9', title: '9 Stk'),
    S2Choice<String>(value: '6', title: '6 Stk')
  ];
  List<S2Choice<String>> pizzaSize = [
    S2Choice<String>(value: '30', title: '30cm Ø'),
    S2Choice<String>(value: '26', title: '26cm Ø')
  ];
  List<S2Choice<String>> pizzaBreadBox = [
    S2Choice<String>(value: '10', title: '10 Stk'),
    S2Choice<String>(value: '6', title: '6 Stk')
  ];
  List<S2Choice<String>> salad = [
    S2Choice<String>(value: 'big', title: 'Groß'),
    S2Choice<String>(value: 'small', title: 'Klein')
  ];
  static const pizzaBreadItemList = [46, 47];
  static const imbissItemList = [108, 109, 110, 111];

  refresh() {
    setState(() {});
  }

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  Widget _sizeWidget(FoodItem foodItem) {
    if (foodItem.category == Food.PIZZA) {
      if (pizzaBreadItemList.contains(foodItem.index)) {
        if (foodItem.size == null) {
          foodItem.size = "6 Stk";
        }
        return CustomDropDown(
          list: pizzaBreadBox,
          initialValue: "6",
          foodItem: foodItem,
          notifyParent: refresh,
        );
      } else {
        if (foodItem.size == null) {
          foodItem.size = "26 Ø";
        }
        return CustomDropDown(
          list: pizzaSize,
          initialValue: "26",
          foodItem: foodItem,
          notifyParent: refresh,
        );
      }
    } else if (foodItem.category == Food.IMBISS) {
      if (imbissItemList.contains(foodItem.index)) {
        if (foodItem.size == null) {
          foodItem.size = "6 Stk";
        }
        return CustomDropDown(
          list: imbissBox,
          initialValue: "6",
          foodItem: foodItem,
          notifyParent: refresh,
        );
      } else {
        return Container();
      }
    } else if (foodItem.category == Food.SALAT) {
      if (foodItem.size == null) {
        foodItem.size = "Klein";
      }
      return CustomDropDown(
        list: salad,
        initialValue: "small",
        foodItem: foodItem,
        notifyParent: refresh,
      );
    } else {
      return Container();
    }
  }

  _extraIndigrendWidget(ChoosenIndigrendsNotifier indigrends) {
    List pastaWithCheeseList = [51, 52, 53, 54, 61, 62, 65, 66, 67, 69, 70];
    List pastaWithMeatList = [61, 62, 51];
    return Column(children: [
      pastaWithCheeseList.contains(widget.index)
          ? CheckboxListTile(
              key: extraCheeseKey,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              checkColor: white,
              activeColor: green_light,
              title: Padding(
                padding: const EdgeInsets.only(right: 82.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "überbacken",
                      style: fontAppBarTitleSwitched,
                    ),
                    AutoSizeText(
                      "1,50 €",
                      style: fontAppBarTitleSwitched,
                    ),
                  ],
                ),
              ),
              value: _isChecked,
              onChanged: (bool value) {
                if (value) {
                  List<dynamic> tmpIndigrends = <dynamic>[];
                  tmpIndigrends.add(
                    Indigrends(
                      id: 1410,
                      category: 0,
                      name: "überbacken",
                      price: 1.50,
                    ),
                  );
                  indigrends.addChoosenIndigrends(tmpIndigrends, widget);
                } else {
                  indigrends.removeIndigrend(1410, widget);
                }
                setState(() {
                  _isChecked = value;
                });
              },
            )
          : Container(),
      pastaWithMeatList.contains(widget.index)
          ? CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              checkColor: white,
              activeColor: green_light,
              key: extraMeatKey,
              title: Padding(
                padding: const EdgeInsets.only(right: 82.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "doppelt Fleisch",
                      style: fontAppBarTitleSwitched,
                    ),
                    AutoSizeText(
                      "2,00 €",
                      style: fontAppBarTitleSwitched,
                    ),
                  ],
                ),
              ),
              value: _isCheckedMeat,
              onChanged: (bool value) {
                if (value) {
                  List<dynamic> tmpIndigrends = <dynamic>[];
                  tmpIndigrends.add(
                    Indigrends(
                      id: 1420,
                      category: 0,
                      name: "doppelt Fleisch",
                      price: 2.00,
                    ),
                  );
                  indigrends.addChoosenIndigrends(tmpIndigrends, widget);
                } else {
                  indigrends.removeIndigrend(1420, widget);
                }
                setState(() {
                  _isCheckedMeat = value;
                });
              },
            )
          : Container(),
      /*widget.category == Food.BURGER
          ? CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              checkColor: white,
              activeColor: green_light,
              key: extraMeatKey,
              title: Padding(
                padding: const EdgeInsets.only(right: 82.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "extra Patty",
                      style: fontAppBarTitleSwitched,
                    ),
                    AutoSizeText(
                      "2,50 €",
                      style: fontAppBarTitleSwitched,
                    ),
                  ],
                ),
              ),
              value: _isCheckedBurger,
              onChanged: (bool value) {
                if (value) {
                  List<dynamic> tmpIndigrends = <dynamic>[];
                  tmpIndigrends.add(
                    Indigrends(
                      id: 1430,
                      category: 0,
                      name: "extra Patty",
                      price: 2.50,
                    ),
                  );
                  indigrends.addChoosenIndigrends(tmpIndigrends, widget);
                } else {
                  indigrends.clear();
                }
                setState(() {
                  _isCheckedBurger = value;
                });
              },
            )
          : Container()*/
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartNotifier>(context);
    var open = Provider.of<OpeningNotifier>(context);
    var animate = Provider.of<AnimateNotifier>(context);
    var indigrends =
        Provider.of<ChoosenIndigrendsNotifier>(context, listen: true);
    var sauce = Provider.of<ChoosenSauceNotifier>(context, listen: true);
    List<dynamic> choosenIndigrendList = <dynamic>[];

    if (indigrends.choosenIndigrends != null) {
      if (indigrends.actualFoodItem == widget) {
        choosenIndigrendList.addAll(indigrends.choosenIndigrends);
      }
    }
    if (sauce.choosenSauce != null) {
      if (sauce.actualFoodItem == widget) {
        choosenIndigrendList.addAll(sauce.choosenSauce);
      }
    }
    return Padding(
      padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: Container(
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 750),
          expandedHeaderPadding: EdgeInsets.all(0),
          expansionCallback: (int index, bool isExpanded) {
            setState(
              () {
                isItemExpanded = !isExpanded;
              },
            );
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          AutoSizeText(
                            widget.index.toString() + ".",
                            style: fontFoodItemIndex,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: AutoSizeText(
                                        widget.name,
                                        style: fontFoodItemName,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.48,
                                      child: AutoSizeText(
                                        widget.description,
                                        style: fontFoodItemDescription,
                                      ),
                                    ),
                                  ],
                                ),
                                AutoSizeText(
                                  Utils.calcFoodItemPrice(
                                              _n, widget, choosenIndigrendList)
                                          .toStringAsFixed(2) +
                                      " €",
                                  style: fontFoodItemPrice,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Column(
                          children: [
                            widget.priceSmall != 0.0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      right: 150,
                                    ),
                                    child: _sizeWidget(widget),
                                  )
                                : Container(),
                            _extraIndigrendWidget(indigrends),
                            Utils.getSauces(widget.category, widget.sauces) !=
                                    null
                                ? widget.category == Food.DREHSPIESS
                                    ? SauceMultiSelectFree(
                                        datasource: Utils.getSauces(
                                            widget.category, widget.sauces),
                                        titleText: "Soßenauswahl",
                                        hintText: "Mehrere auswählbar",
                                        key: saucekey,
                                        foodItem: widget,
                                      )
                                    : widget.category == Food.SALAT
                                        ? SauceSingleSelect(
                                            datasource: Utils.getSauces(
                                                widget.category, widget.sauces),
                                            titleText: "Soßenauswahl",
                                            hintText: "Eine auswählbar",
                                            key: saucekey,
                                            foodItem: widget,
                                          )
                                        : SauceMultiSelect(
                                            datasource: Utils.getSauces(
                                                widget.category, widget.sauces),
                                            titleText: "Soßenauswahl",
                                            hintText: "Mehrere auswählbar",
                                            key: saucekey,
                                            foodItem: widget,
                                          )
                                : Container(),
                            Utils.getIndigrends(widget.category,
                                        widget.indigrends, widget) !=
                                    null
                                ? IndigrendsMultiSelect(
                                    datasource: Utils.getIndigrends(
                                        widget.category,
                                        widget.indigrends,
                                        widget),
                                    titleText: "Ihre Extras",
                                    hintText: "Mehrere auswählbar",
                                    key: indigrendKey,
                                    foodItem: widget,
                                  )
                                : Container(),
                          ],
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          decoration: BoxDecoration(
                            color: purple_light,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1.5,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      child: Container(
                                        child: AutoSizeText("-",
                                            style: fontNumberMath),
                                      ),
                                      onTap: () => minus(),
                                    ),
                                    AutoSizeText('$_n', style: fontNumber),
                                    InkWell(
                                      child: Container(
                                        child: AutoSizeText("+",
                                            style: fontNumberMath),
                                      ),
                                      onTap: () => add(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                AutoSizeText(
                                  "Anzahl verändern",
                                  style: fontNumberText,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.48,
                          height: 50,
                          child: RaisedButton(
                            color: green_light,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  AromaIcons.warenkorb,
                                  color: white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AutoSizeText(
                                  "In den Warenkorb",
                                  style: TextStyle(color: white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (open.isOpened) {
                                animate.animationController.reset();
                                animate.animationController.forward();
                                cart.addToCart(
                                    cart.cart.length,
                                    _n,
                                    widget,
                                    indigrends.choosenIndigrends,
                                    sauce.choosenSauce);
                                setState(() {
                                  isItemExpanded = false;
                                  indigrends.clear();
                                  sauce.clear();
                                  _isChecked = false;
                                });
                              } else {
                                final snackBar = SnackBar(
                                    content: AutoSizeText(
                                        'Leider haben wir derzeit nicht geöffnet!'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FoodItemAllergensButton(
                      foodItem: widget,
                    ),
                  ],
                ),
              ),
              isExpanded: isItemExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
