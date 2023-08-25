
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/order.dart';

class OrderResponse {
  List<OrdersData>? data;
  String? status;
  String? message;
  int? statusCode;

  OrderResponse({this.data, this.status, this.message, this.statusCode});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrdersData>[];
      json['data'].forEach((v) {
        data?.add(OrdersData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  OrderResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (data != null) {
    //  data['data'] = data.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}