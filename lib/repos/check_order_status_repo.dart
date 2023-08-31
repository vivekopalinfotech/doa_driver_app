
import 'package:doa_driver_app/api/api_provider.dart';

abstract class OrderStatusRepo {
  checkOrderStatus(String id,String status);
}

class RealOrderStatusRepo implements OrderStatusRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  checkOrderStatus(String id,String status) {
    return apiProvider.checkOrderStatus(id,status);
  }
}
