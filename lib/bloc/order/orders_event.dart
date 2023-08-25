part of 'order_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class GetOrders extends OrdersEvent {
  const GetOrders();

  @override
  List<Object> get props => [];
}
