import 'dart:convert';
import '../Items/shoppingcart_item.dart';
import 'devices.dart';
import 'order_item.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/common.dart';

class Order {
  String? id;
  int? table;
  String? orderTime;
  double? price;
  int? status;
  int? printed;

  Order({
    this.id,
    this.table,
    this.orderTime,
    this.price,
    this.status,
    this.printed,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const getAllOrdersByOrderIdAction = 'GET_ALL_OPEN_ORDERS_BY_ORDERID';
  static const makeOrderAction = 'MAKE_ORDER';
  static const updateOrderAction = 'UPDATE_ORDER';
  static const getOpenOrderByTableAction = 'GET_OPEN_ORDER_BY_TABLE';

  static Future<Order?> getOpenOrderByTable(int tableNumber) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getOpenOrderByTableAction;
      map['table'] = tableNumber.toString();
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Order>? orderList = parseResponse(response.body);
        return orderList!.first;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Order?>> geOrdersByOrderId(String orderId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getAllOrdersByOrderIdAction;
      map['orderId'] = orderId;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Order>? orderList = parseResponse(response.body);
        return orderList!;
      } else {
        return <Order>[];
      }
    } catch (e) {
      return <Order>[];
    }
  }

  static Future makeOrder(
    int table,
    String orderTime,
    int status,
    double price,
    List<ShoppingCartItem> shoppingCart,
  ) async {
    try {
      String id = Utils.idGenerator();
      var map = <String, dynamic>{};
      map['action'] = makeOrderAction;
      map['id'] = id;
      map['table'] = table.toString();
      map['status'] = status.toString();
      map['orderTime'] = orderTime;
      map['price'] = price.toString();
      for (ShoppingCartItem actualItem in shoppingCart) {
        OrderItem.insertOrderEntries(
          actualItem.id!,
          id,
          actualItem.productName,
          actualItem.count.toString(),
          actualItem.additionalIndigrend!,
          actualItem.price,
          0,
        );
      }
      await http.post(Uri.parse(root), body: map);
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("SSO");

      Device.insertDevice(userId!, id);
    } catch (e) {
      return "error";
    }
  }

  static Future updateOrder(
    String id,
    int table,
    String orderTime,
    double price,
    int status,
    int printed,
    List<ShoppingCartItem> shoppingCart,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = updateOrderAction;
      map['id'] = id;
      map['table'] = table.toString();
      map['orderTime'] = orderTime;
      map['price'] = price.toString();
      map['status'] = status.toString();
      map['printed'] = printed.toString();
      try {
        if (status == 1) {
          for (ShoppingCartItem item in shoppingCart) {
            OrderItem.updateOrderEntries(item.id!, item.productName, item.count,
                item.additionalIndigrend!, item.price, 1, 0, item.count);
          }
        } else {
          List<OrderItem?> dbList = await OrderItem.getOrderItems(id);
          if (dbList.isNotEmpty) {
            for (ShoppingCartItem actualItem in shoppingCart) {
              int index = dbList.indexWhere((element) =>
                  element!.itemName == actualItem.productName &&
                  element.additionalIndigrends ==
                      actualItem.additionalIndigrend);

              if (index != -1) {
                OrderItem.updateOrderEntries(
                  dbList[index]!.id!,
                  actualItem.productName,
                  actualItem.count + dbList[index]!.count!,
                  actualItem.additionalIndigrend!,
                  actualItem.price,
                  0,
                  0,
                  dbList[index]!.countPayed!,
                );
              } else {
                OrderItem.insertOrderEntries(
                  actualItem.id!,
                  id,
                  actualItem.productName,
                  actualItem.count.toString(),
                  actualItem.additionalIndigrend!,
                  actualItem.price,
                  0,
                );
              }
            }
          } else {
            for (ShoppingCartItem actualItem in shoppingCart) {
              OrderItem.insertOrderEntries(
                actualItem.id!,
                id,
                actualItem.productName,
                actualItem.count.toString(),
                actualItem.additionalIndigrend!,
                actualItem.price,
                0,
              );
            }
          }
        }
        final prefs = await SharedPreferences.getInstance();
        String? userId = prefs.getString("SSO");
        if (status == 0) {
          Device.insertDevice(userId!, id);
        } else {
          Device.deleteDevice(userId!, id);
        }
      } catch (e) {
        print(e.toString());
      }

      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static List<Order>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Order>((json) => Order.fromJason(json)).toList();
  }

  factory Order.fromJason(Map<String, dynamic> json) {
    return Order(
      id: json["id"] == null ? "" : json["id"] as String,
      table: json["table"] == null ? 0 : int.parse(json["table"] as String),
      orderTime: json["orderTime"] == null ? "" : json["orderTime"] as String?,
      price:
          json["price"] == null ? 0.0 : double.parse(json["price"] as String),
      status:
          json["finished"] == null ? 0 : int.parse(json["finished"] as String),
      printed:
          json["printed"] == null ? 0 : int.parse(json["printed"] as String),
    );
  }
}
