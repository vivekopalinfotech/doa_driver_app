import 'package:doa_driver_app/constants/app_constants.dart';
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
        emit(const OrderStatusLoading());
        final orderStatusResponse = await orderStatusRepo.checkOrderStatus(event.id, event.status, event.paid_cash, event.paid_cc_terminal);
        print(orderStatusResponse.status);
        if (orderStatusResponse.status == AppConstants.STATUS_SUCCESS) {
          if (event.status == 'Delivery Stop') {
            yield DeliveryStopSuccess(orderStatusResponse.message);
            yield const OrderStatusInitial();
          } else if (event.status == 'Not At Home') {
            yield NotHomeSuccess(orderStatusResponse.message);
            yield const OrderStatusInitial();
          } else if (event.status == 'Delivery Cancel') {
            yield DeliveryCancelSuccess(orderStatusResponse.message);
            yield const OrderStatusInitial();
          } else {
            yield OrderStatusSuccess(orderStatusResponse.message);
            yield const OrderStatusInitial();
          }
        } else {
          yield OrderStatusFailed(orderStatusResponse.message);
          yield const OrderStatusInitial();
        }
      } on Error {
        yield const OrderStatusFailed("Some Error");
        yield const OrderStatusInitial();
      }
    }
  }
}
