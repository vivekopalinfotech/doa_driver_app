


import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';
import 'package:doa_driver_app/api/responses/logout_response.dart';

abstract class ProfileRepo {
  Future<LoginResponse> updateProfile(String id,String vehicleNo, String vehicleColor, String firstName, String lastName, String code);


}

class RealProfileRepo implements ProfileRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<LoginResponse> updateProfile(String id,String vehicleNo, String vehicleColor, String firstName, String lastName, String code) {
    return apiProvider.updateProfile(id,vehicleNo,vehicleColor,firstName,lastName,code);
  }


}

