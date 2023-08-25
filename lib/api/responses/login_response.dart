import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/user.dart';

class LoginResponse {
  String? status;
  User? data;
//  String? message;

  LoginResponse({this.status, this.data, });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
    //  message = json['message'];
  }

  LoginResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    data = null;
    //  message = error ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    //  data['message'] = message;
    return data;
  }
}