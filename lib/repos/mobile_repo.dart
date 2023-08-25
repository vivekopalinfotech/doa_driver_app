
import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/mobile_rsponse.dart';

abstract class MobileRepo {
  Future<MobileResponse> phoneNo(String mobile);
}

class RealMobileRepo implements MobileRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<MobileResponse> phoneNo(String phoneNumber) {
    return apiProvider.phoneNo(phoneNumber);
  }
}
