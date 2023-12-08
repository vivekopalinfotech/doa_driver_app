


import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';
import 'package:doa_driver_app/api/responses/logout_response.dart';

abstract class ProfileRepo {
  Future<LogoutResponse> updateProfile(String id);


}

class RealProfileRepo implements ProfileRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<LogoutResponse> updateProfile(String id,) {
    return apiProvider.updateProfile(id);
  }


}

