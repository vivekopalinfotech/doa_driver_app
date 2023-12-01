

import 'package:doa_driver_app/constants/app_constants.dart';

class DeliveryStatusResponse {
  String? status;
  String? message;
  Data? deliveryData;

  DeliveryStatusResponse({this.status, this.message});

  DeliveryStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    deliveryData = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  DeliveryStatusResponse.withError(String error){
    status = AppConstants.STATUS_ERROR;
    message = error;
    deliveryData = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.deliveryData != null) {
      data['data'] = this.deliveryData?.toJson();
    }
    return data;
  }
}
class Data {
  int? id;
  String? customer_id;

  Data(
      {this.id,
        this.customer_id,

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer_id = json['customer_id'];
     }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customer_id;
   return data;
  }
}