
import 'package:doa_driver_app/api/api_provider.dart';

abstract class UpdateShiftRepo {
  Future updateShift(int id, int status, String fcm_token);
}

class RealUpdateShiftRepo implements UpdateShiftRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future updateShift(int id, int status, String fcm_token) {
    return apiProvider.updateShift(id, status, fcm_token);
  }
}
