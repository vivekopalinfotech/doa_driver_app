
part of 'check_order_status_bloc.dart';
abstract class OrderStatusEvent extends Equatable {
  const OrderStatusEvent();
}

class CheckOrderStatus extends OrderStatusEvent {
  final String id;
  final String status;

  const CheckOrderStatus(this.id,this.status);

  @override
  List<Object> get props => [id,status];
}


