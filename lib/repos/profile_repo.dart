


import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';
import 'package:doa_driver_app/api/responses/logout_response.dart';

abstract class AuthRepo {
  Future<LoginResponse> loginUser(String id, String password);
  Future<LogoutResponse> logoutUser();

}

class RealAuthRepo implements AuthRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<LoginResponse> loginUser(String email, String password) {
    return apiProvider.loginUser(email, password);
  }


  @override
  Future<LogoutResponse> logoutUser() {
    return ApiProvider().doLogout();
  }

}

class FakeAuthRepo implements AuthRepo {
  @override
  Future<LoginResponse> loginUser(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<LogoutResponse> logoutUser() {
    throw UnimplementedError();
  }


}