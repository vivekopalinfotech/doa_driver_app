import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';


abstract class LatLngRepo {
  Future<String> updateLatLng(
    String id,
    String latLng,
  );
}

class RealLatLngRepo implements LatLngRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<String> updateLatLng(
    String id,
    String latLng,
  ) {
    return apiProvider.updateLatLong(id, latLng);
  }
}
