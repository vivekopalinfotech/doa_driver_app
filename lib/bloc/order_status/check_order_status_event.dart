
part of 'check_order_status_bloc.dart';
abstract class OrderStatusEvent extends Equatable {
  const OrderStatusEvent();
}

class CheckOrderStatus extends OrderStatusEvent {
  final String id;
  final String status;
  final double paid_cash;
  final double paid_cc_terminal;

  const CheckOrderStatus(this.id,this.status, this.paid_cash, this.paid_cc_terminal);

  @override
  List<Object> get props => [id,status];
}


