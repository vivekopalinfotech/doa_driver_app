
import 'package:doa_driver_app/api/api_provider.dart';

abstract class OnlineRepo {
  Future<String> online(String id,String status);
}

class RealOnlineRepo implements OnlineRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<String> online(String id,String status) {
    return apiProvider.online(id,status);
  }
}
