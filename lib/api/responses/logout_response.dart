

import 'package:doa_driver_app/constants/app_constants.dart';

class LogoutResponse {

  String? message;

  LogoutResponse({this.message});

  LogoutResponse.fromJson(Map<String, dynamic> json) {

    message = json['message'];
  }

  LogoutResponse.withError(String error){

    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    return data;
  }
}
