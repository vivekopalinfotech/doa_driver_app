import 'package:doa_driver_app/repos/check_order_status_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'check_order_status_event.dart';
part 'check_order_status_state.dart';

class OrderStatusBloc extends Bloc<OrderStatusEvent, OrderStatusState> {
  final OrderStatusRepo orderStatusRepo;

  OrderStatusBloc(this.orderStatusRepo) : super(const OrderStatusInitial());

  @override
  Stream<OrderStatusState> mapEventToState(OrderStatusEvent event) async* {
    if (event is CheckOrderStatus) {
      try {
        final orderStatusResponse = await orderStatusRepo.checkOrderStatus(event.id,event.status);
        if (orderStatusResponse.isNotEmpty) {
          yield OrderStatusSuccess(orderStatusResponse);
        } else {
          yield OrderStatusFailed(orderStatusResponse);
        }
      } on Error {
        yield const OrderStatusFailed("Some Error");
      }
    }
  }
}
