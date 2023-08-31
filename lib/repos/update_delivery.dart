import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/delivery_update_response.dart';

abstract class DeliveryUpdateRepo {
  Future<DeliveryUpdateResponse> getDeliveryUpdate();
}

class RealDeliveryUpdateRepo implements DeliveryUpdateRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DeliveryUpdateResponse> getDeliveryUpdate() {
    _apiProvider = ApiProvider();
    return _apiProvider.getDeliveryUpdate();
  }

}
