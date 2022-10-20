import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final String date;
  final double price;
  final String food;

  const OrderItem({Key key, this.date, this.price, this.food})
      : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isItemExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, bottom: 5, right: 8),
      child: Container(
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 750),
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
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.date,
                          style: fontFoodItemName,
                        ),
                        Text(
                          widget.price.toStringAsFixed(2) + "€",
                          style: fontFoodItemPrice,
                        ),
                      ],
                    ),
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 25, right: 20, bottom: 10),
                child: SizedBox(
                  child: Row(
                    children: [
                      widget.food!=null ? Flexible(
                        child: SizedBox(
                          child: Text(
                            widget.food,
                            style: fontFoodItemName,
                          ),
                        ),
                      ): Container(),
                    ],
                  ),
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
