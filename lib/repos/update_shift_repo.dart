
import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';

abstract class UpdateShiftRepo {
  Future<LoginResponse> updateShift(int id, int status, String fcm_token);
}

class RealUpdateShiftRepo implements UpdateShiftRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<LoginResponse> updateShift(int id, int status, String fcm_token) {
    return apiProvider.updateShift(id, status, fcm_token);
  }
}
