
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
  double? Total_Pending_Amount;
  double? Total_Deliver_Amount;
  double? Total_cash;
  double? Total_cc;
  double? Total_Shipping_cost;
  int? Total_Pending_Order;
  int? Total_cc_order;
  int? Total_cash_order;
  String? Availability_status;


  ShiftsData({this.Total_Deliver_Order,this.Total_Pending_Amount,this.Total_Deliver_Amount, this.Total_cash, this.Total_cc,this.Total_Shipping_cost, this.Total_Pending_Order,this.Total_cc_order,this.Total_cash_order, this.Availability_status});

  ShiftsData.fromJson(Map<String, dynamic> json) {
    Total_Deliver_Order = json['Total_Deliver_Order'];
    Total_Pending_Amount = double.parse(json['Total_Pending_Amount'].toString());
    Total_Deliver_Amount = double.parse(json['Total_Deliver_Amount'].toString());
    Total_cash = double.parse(json['Total_cash'].toString());
    Total_cc = double.parse(json['Total_cc'].toString());
    Total_Shipping_cost = double.parse(json['Total_Shipping_cost'].toString());
    Total_Pending_Order = json['Total_Pending_Order'];
    Total_cc_order = json['Total_cc_order'];
    Total_cash_order = json['Total_cash_order'];
    Availability_status = json['Availability_status'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total_Deliver_Order'] = Total_Deliver_Order;
    data['Total_Pending_Amount'] = Total_Pending_Amount;
    data['Total_Deliver_Amount'] = Total_Deliver_Amount;
    data['Total_cash'] = Total_cash;
    data['Total_cc'] = Total_cc;
    data['Total_Shipping_cost'] = Total_Shipping_cost;
    data['Total_Pending_Order'] = Total_Pending_Order;
    data['Total_cc_order'] = Total_cc_order;
    data['Total_cash_order'] = Total_cash_order;
    data['Availability_status'] = Availability_status;

    return data;
  }
}