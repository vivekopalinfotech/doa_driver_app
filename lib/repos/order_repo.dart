import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/order_response.dart';

abstract class OrderRepo {
  Future<OrderResponse> getOrder(int id);
}

class RealOrderRepo implements OrderRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrderResponse> getOrder(int id) {
    _apiProvider = ApiProvider();
    return _apiProvider.getOrder(id);
  }
}
