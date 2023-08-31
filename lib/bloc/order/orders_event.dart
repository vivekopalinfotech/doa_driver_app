part of 'order_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class GetOrders extends OrdersEvent {
  int? id;
   GetOrders(this.id);

  @override
  List<Object> get props => [id!];
}
