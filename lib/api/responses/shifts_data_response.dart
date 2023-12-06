
import 'package:doa_driver_app/constants/app_constants.dart';

class ShiftsDataResponse {
  String? status;
  ShiftsData? data;


  ShiftsDataResponse({this.status, this.data,});

  ShiftsDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ShiftsData.fromJson(json['data']) : null;
  }

  ShiftsDataResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    data = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class ShiftsData{
  int? Total_Deliver_Order;
  int? Total_Pending_Amount;
  int? Total_Deliver_Amount;
  int? Total_cash;
  int? Total_cc;
  int? Total_Pending_Order;
  String? Availability_status;


  ShiftsData({this.Total_Deliver_Order,this.Total_Pending_Amount,this.Total_Deliver_Amount, this.Total_cash, this.Total_cc, this.Total_Pending_Order, this.Availability_status});

  ShiftsData.fromJson(Map<String, dynamic> json) {
    Total_Deliver_Order = json['Total_Deliver_Order'];
    Total_Pending_Amount = json['Total_Pending_Amount'];
    Total_Deliver_Amount = json['Total_Deliver_Amount'];
    Total_cash = json['Total_cash'];
    Total_cc = json['Total_cc'];
    Total_Pending_Order = json['Total_Pending_Order'];
    Availability_status = json['Availability_status'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total_Deliver_Order'] = Total_Deliver_Order;
    data['Total_Pending_Amount'] = Total_Pending_Amount;
    data['Total_Deliver_Amount'] = Total_Deliver_Amount;
    data['Total_cash'] = Total_cash;
    data['Total_cc'] = Total_cc;
    data['Total_Pending_Order'] = Total_Pending_Order;
    data['Availability_status'] = Availability_status;

    return data;
  }
}