
import 'package:doa_driver_app/constants/app_constants.dart';

class MobileResponse {
  String? status;
  Data? data;


  MobileResponse({this.status, this.data,});

  MobileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  MobileResponse.withError(String error) {
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

class Data{
  String? Code;
  String? mobile;
  String? user;

  Data({this.Code, this.mobile, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    Code = json['Code'];
    mobile = json['mobile'];
    user = json['user'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Code'] = Code;
    data['mobile'] = mobile;
    data['user'] = user;
    return data;
  }
}