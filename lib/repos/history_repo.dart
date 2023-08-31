import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/order_response.dart';

abstract class HistoryRepo {
  Future<OrderResponse> getHistory(int id);
}

class RealHistoryRepo implements HistoryRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrderResponse> getHistory(int id) {
    _apiProvider = ApiProvider();
    return _apiProvider.getHistory(id);
  }
  
}
