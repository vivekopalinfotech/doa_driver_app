
import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';

abstract class OtpRepo {
  Future<LoginResponse> otp(String mobile,String otp);
}

class RealOtpRepo implements OtpRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<LoginResponse> otp(String mobile,String otp) {
    return apiProvider.otp(mobile,otp);
  }
}
