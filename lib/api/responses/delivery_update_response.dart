import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/user.dart';

class DeliveryUpdateResponse {
  String? status;
  int? today_order;
  int? Pending_order;
  int? complete_order;
//  String? message;

  DeliveryUpdateResponse({this.status,this.today_order,this.Pending_order, this.complete_order });

  DeliveryUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    today_order = json['today_order'];
    Pending_order = json['Pending_order'];
    complete_order = json['complete_order'];

    //  message = json['message'];
  }

  DeliveryUpdateResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    today_order = null;
    Pending_order = null;
    complete_order = null;
    //  message = error ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['today_order'] = today_order;
    data['Pending_order'] = Pending_order;
    data['complete_order'] = complete_order;

    //  data['message'] = message;
    return data;
  }
}