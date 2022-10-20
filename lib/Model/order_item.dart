import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class OrderItem {
  String? id;
  String? orderId;
  String? itemName;
  double? itemPrice;
  String? additionalIndigrends;
  int? count;
  int? payed;
  int? printed;
  int? countPayed;

  OrderItem({
    this.id,
    this.orderId,
    this.itemName,
    this.itemPrice,
    this.count,
    this.additionalIndigrends,
    this.payed,
    this.printed,
    this.countPayed,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const insertOrderEntriesAction = 'INSERT_ORDER_ENTRIES';
  static const getOrderItemsByOrder = 'GET_ALL_ORDERITEMS_BY_ORDERID';
  static const updateOrderEntriesAction = 'UPDATE_ORDER_ENTRIES';
  static const updateOrderEntriesWithoutCountAction =
      'UPDATE_ORDER_ENTRIES_WITHOUT_COUNT';

  static Future updateOrderEntries(
      String id,
      String itemName,
      int count,
      String additionalIndigrends,
      double itemPrice,
      int payed,
      int printed,
      int countPayed) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = updateOrderEntriesAction;
      map['itemName'] = itemName;
      map['count'] = count.toString();
      map['additionalIndigrends'] = additionalIndigrends;
      map['price'] = itemPrice.toString();
      map['payed'] = payed.toString();
      map['printed'] = printed.toString();
      map['countPayed'] = countPayed.toString();
      map['id'] = id;
      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static Future updateOrderEntriesWithoutCount(
      String id,
      String itemName,
      String additionalIndigrends,
      double itemPrice,
      int payed,
      int printed,
      int countPayed) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = updateOrderEntriesWithoutCountAction;
      map['itemName'] = itemName;
      map['additionalIndigrends'] = additionalIndigrends;
      map['price'] = itemPrice.toString();
      map['payed'] = payed.toString();
      map['printed'] = printed.toString();
      map['countPayed'] = countPayed.toString();
      map['id'] = id;
      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static Future<List<OrderItem?>> getOrderItems(String orderId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getOrderItemsByOrder;
      map['orderId'] = orderId;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<OrderItem>? orderItemList = parseResponse(response.body);
        return orderItemList!;
      } else {
        return <OrderItem>[];
      }
    } catch (e) {
      return <OrderItem>[];
    }
  }

  static Future insertOrderEntries(
    String id,
    String orderId,
    String itemName,
    String count,
    String additionalIndigrends,
    double itemPrice,
    int payed,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = insertOrderEntriesAction;
      map['id'] = id;
      map['orderId'] = orderId;
      map['itemName'] = itemName;
      map['count'] = count;
      map['additionalIndigrends'] = additionalIndigrends;
      map['itemPrice'] = itemPrice.toString();
      map['payed'] = payed.toString();
      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static List<OrderItem>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OrderItem>((json) => OrderItem.fromJason(json)).toList();
  }

  factory OrderItem.fromJason(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"] == null ? '' : json["id"] as String,
      orderId: json["orderId"] == null ? "" : json["orderId"] as String,
      itemName: json["itemName"] == null ? "" : json["itemName"] as String?,
      additionalIndigrends: json["additionalIndigrends"] == null
          ? ''
          : json["additionalIndigrends"] as String?,
      itemPrice:
          json["price"] == null ? 0.0 : double.parse(json["price"] as String),
      count: json["count"] == null ? 0 : int.parse(json["count"] as String),
      payed: json["payed"] == null ? 0 : int.parse(json["payed"] as String),
      printed:
          json["printed"] == null ? 0 : int.parse(json["printed"] as String),
      countPayed: json["countPayed"] == null
          ? 0
          : int.parse(json["countPayed"] as String),
    );
  }
}
