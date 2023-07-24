

import 'package:doa_driver_app/constants/app_constants.dart';

class LogoutResponse {
  String? status;
  String? message;

  LogoutResponse({this.status, this.message});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  LogoutResponse.withError(String error){
    status = AppConstants.STATUS_ERROR;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
