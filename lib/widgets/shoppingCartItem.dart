import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatefulWidget {
  final FoodItem foodItem;
  final List<dynamic> choosenIndigrends;
  int quantity;
  String annotation;
  String size;
  bool isSmall;

  ShoppingCartItem(
      {Key key,
      this.foodItem,
      this.choosenIndigrends,
      this.quantity,
      this.annotation,
      this.size,
      this.isSmall})
      : super(key: key);

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  int _n = 1;
  TextEditingController _textFieldController = TextEditingController();

  void minus() {
    setState(() {
      if (_n != 1) {
        _n--;
        widget.quantity--;
      }
    });
  }

  void add() {
    setState(() {
      _n++;
      widget.quantity++;
    });
  }

  Widget _foodName(FoodItem foodItem) {
    if (foodItem.priceSmall != 0.0) {
      return Column(
        children: [
          Text(
            widget.foodItem.name,
            style: fontFoodItemName,
          ),
          Text(
            widget.size,
            style: fontFoodItemName,
          )
        ],
      );
    } else {
      return Text(
        widget.foodItem.name,
        style: fontFoodItemName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartNotifier>(context);
    _n = widget.quantity;
    return Dismissible(
      background: Container(color: Colors.red, child: Icon(Icons.cancel)),
      key: UniqueKey(),
      onDismissed: (direction) {
        cartProvider.clear(widget);
        setState(
          () {},
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$_n x",
                    style: fontFoodItemIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              /*Text(
                                widget.foodItem.name,
                                style: fontFoodItemName,
                              ),*/
                              _foodName(widget.foodItem),
                            ],
                          ),
                          widget.choosenIndigrends != null &&
                                  widget.choosenIndigrends.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: GridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        scrollDirection: Axis.vertical,
                                        childAspectRatio: 3.5,
                                        children: List.generate(
                                            widget.choosenIndigrends.length,
                                            (index) {
                                          return Card(
                                            color: grey,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  widget
                                                      .choosenIndigrends[index]
                                                      .name,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 11),
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    AromaIcons.plus,
                                    color: purple_light,
                                    size: 13,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  widget.annotation == null
                                      ? Text(
                                          "Anmerkung hinzufügen",
                                          style: TextStyle(
                                              color: purple_light,
                                              fontSize: 10),
                                        )
                                      : Text(
                                          widget.annotation,
                                          style: TextStyle(
                                              color: purple_light,
                                              fontSize: 10),
                                        )
                                ],
                              ),
                            ),
                            onTap: () {
                              _displayDialog(context, cartProvider);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        Utils.calcShoppingCartItemPrice(
                              _n,
                              widget,
                              widget.choosenIndigrends,
                            ).toStringAsFixed(2) +
                            " €",
                        style: fontFoodItemName,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: InkWell(
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: green_light,
                              ),
                              onTap: () {
                                minus();
                                widget.quantity = _n;
                                cartProvider.update();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            child: InkWell(
                              child: Icon(
                                Icons.add_circle_outline,
                                color: green_light,
                              ),
                              onTap: () {
                                add();
                                widget.quantity = _n;
                                cartProvider.update();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displayDialog(BuildContext context, CartNotifier notifier) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ihre Anmerkung'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Ihre Anmerkung"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  widget.annotation = _textFieldController.text;
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
