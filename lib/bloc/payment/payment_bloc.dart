import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/repos/check_order_status_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final OrderStatusRepo orderStatusRepo;

  PaymentBloc(this.orderStatusRepo) : super(const PaymentInitial());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is CheckPayment) {
      try {
        emit(PaymentLoading());
        final orderStatusResponse = await orderStatusRepo.checkOrderStatus(event.id,event.status,event.paid_cash,event.paid_cc_terminal);
        print(orderStatusResponse.status);
        if (orderStatusResponse.status == AppConstants.STATUS_SUCCESS ) {
          yield PaymentSuccess(orderStatusResponse.message);
          yield const PaymentInitial();
        } else {
          yield PaymentFailed(orderStatusResponse.message);
          yield const PaymentInitial();
        }

      } on Error {
        yield const PaymentFailed("Some Error");
        yield const PaymentInitial();
      }
    }
  }
}
