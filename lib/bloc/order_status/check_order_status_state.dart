
part of 'check_order_status_bloc.dart';

abstract class OrderStatusState extends Equatable {
  const OrderStatusState();
}

class OrderStatusInitial extends OrderStatusState {
  const OrderStatusInitial();

  @override
  List<Object> get props => [];
}


class OrderStatusSuccess extends OrderStatusState {
  final String? message;

  const OrderStatusSuccess(this.message);

  @override
  List<Object> get props => [message!];
}



class OrderStatusFailed extends OrderStatusState {
  final String? message;

  const OrderStatusFailed(this.message);

  @override
  List<Object> get props => [message!];
}
