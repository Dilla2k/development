import 'package:Aroma/notifier/order_type_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSwitch extends StatefulWidget {
  @override
  _OrderSwitchState createState() => _OrderSwitchState();
}

class _OrderSwitchState extends State<OrderSwitch> {
  @override
  Widget build(BuildContext context) {
    OrderTypeNotifier orderTypeNotifier =
        Provider.of<OrderTypeNotifier>(context, listen: false);
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: orderTypeNotifier.orderType == 1 ? white : transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    "Lieferung",
                    style: orderTypeNotifier.orderType == 1
                        ? fontAppBarTitleSwitched
                        : fontAppBarTitle,
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                orderTypeNotifier.setOrderType(1);
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: orderTypeNotifier.orderType == 1 ? transparent : white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Abholung",
                    style: orderTypeNotifier.orderType == 1
                        ? fontAppBarTitle
                        : fontAppBarTitleSwitched,
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                orderTypeNotifier.setOrderType(0);
              });
            },
          ),
        ],
      ),
    );
  }
}
