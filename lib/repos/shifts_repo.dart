import 'package:doa_driver_app/api/api_provider.dart';
import 'package:doa_driver_app/api/responses/shifts_data_response.dart';

abstract class ShiftsRepo {
  Future<ShiftsDataResponse> getShiftsData(int id);
}

class RealShiftsRepo implements ShiftsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ShiftsDataResponse> getShiftsData(int id) {
    _apiProvider = ApiProvider();
    return _apiProvider.getShiftsData(id);
  }
}
