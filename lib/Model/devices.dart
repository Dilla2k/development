import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/common.dart';

class Device {
  String? userId;
  String? orderId;

  Device({
    this.userId,
    this.orderId,
  });

  static const root = serverName + 'barbossa/web/getData.php';
  static const insertDeviceAction = 'INSERT_DEVICE';
  static const getDeviceAction = 'GET_ORDERS_BY_USERID';
  static const deleteDeviceAction = 'DELETE_DEVICE';

  static Future insertDevice(
    String userId,
    String orderId,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = insertDeviceAction;
      map['userId'] = userId;
      map['orderId'] = orderId;

      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Device?>> getOrdersByUserId(String userId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = getDeviceAction;
      map['userId'] = userId;
      final response = await http.post(Uri.parse(root), body: map);
      if (200 == response.statusCode) {
        List<Device>? orderList = parseResponse(response.body);
        return orderList!;
      } else {
        return <Device>[];
      }
    } catch (e) {
      return <Device>[];
    }
  }

  static Future deleteDevice(
    String userId,
    String orderId,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = deleteDeviceAction;
      map['userId'] = userId;
      map['orderId'] = orderId;

      await http.post(Uri.parse(root), body: map);
    } catch (e) {
      return "error";
    }
  }

  static List<Device>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Device>((json) => Device.fromJason(json)).toList();
  }

  factory Device.fromJason(Map<String, dynamic> json) {
    return Device(
      userId: json["userId"] == null ? "" : json["userId"] as String,
      orderId: json["orderId"] == null ? "" : json["orderId"] as String?,
    );
  }
}
