import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/order_response.dart';

abstract class HistoryRepo {
  Future<OrderResponse> getHistory();
}

class RealHistoryRepo implements HistoryRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrderResponse> getHistory() {
    _apiProvider = ApiProvider();
    return _apiProvider.getHistory();
  }
  
}
