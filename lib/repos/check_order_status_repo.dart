
import 'package:doa_driver_app/api/api_provider.dart';

abstract class OrderStatusRepo {
  checkOrderStatus(String id,String status,double paid_cash,double paid_cc_terminal);
}

class RealOrderStatusRepo implements OrderStatusRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  checkOrderStatus(String id,String status,double paid_cash,double paid_cc_terminal) {
    return apiProvider.checkOrderStatus(id,status,paid_cash,paid_cc_terminal);
  }
}
