import '../Items/background_image.dart';

import '../Items/shoppingcart_item.dart';
import '../Model/devices.dart';
import '../Model/order.dart';
import '../Model/order_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/fade_route.dart';
import 'table_finish_page.dart';
import 'table_order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('SSO');
      List<Device?> deviceList = await Device.getOrdersByUserId(userId!);
      if (deviceList.isNotEmpty) {
        for (Device? actualDevice in deviceList) {
          List<Order?> orderList =
              await Order.geOrdersByOrderId(actualDevice!.orderId!);
          for (Order? actualOrder in orderList) {
            List<OrderItem?> orderItemList =
                await OrderItem.getOrderItems(actualOrder!.id!);
            List<ShoppingCartItem> shoppingCartItemList = [];
            for (OrderItem? actualOrderItem in orderItemList) {
              if (actualOrderItem!.payed == 0) {
                if (actualOrderItem.countPayed == 0) {
                  ShoppingCartItem item = ShoppingCartItem(
                      id: actualOrderItem.id,
                      count: actualOrderItem.count!,
                      additionalIndigrend: actualOrderItem.additionalIndigrends,
                      productName: actualOrderItem.itemName!,
                      price: actualOrderItem.itemPrice!);
                  shoppingCartItemList.add(item);
                } else if (actualOrderItem.countPayed !=
                    actualOrderItem.count) {
                  int count =
                      actualOrderItem.count! - actualOrderItem.countPayed!;
                  ShoppingCartItem item = ShoppingCartItem(
                      id: actualOrderItem.id,
                      count: count,
                      additionalIndigrend: actualOrderItem.additionalIndigrends,
                      productName: actualOrderItem.itemName!,
                      price: actualOrderItem.itemPrice!,
                      countPayed: actualOrderItem.countPayed);
                  shoppingCartItemList.add(item);
                }
              }
            }
            context.read<ShoppingcartNotifier>().setShoppingCartFinishItemList(
                shoppingCartItemList, actualOrder.table!);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const TableOrderPage(),
                      ),
                    );
                  },
                  child: const Text("Bestellung aufnehmen"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 80),
                    primary: primaryColor.withOpacity(0.8),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const TableFinishPage(),
                      ),
                    );
                  },
                  child: const Text("Tisch abschließen"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 80),
                    primary: primaryColor.withOpacity(0.8),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
