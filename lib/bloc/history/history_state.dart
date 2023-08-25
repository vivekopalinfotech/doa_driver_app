part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();

  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();

  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<OrdersData> ordersData;

  const HistoryLoaded(this.ordersData);

  @override
  List<Object> get props => [ordersData];
}


class HistoryError extends HistoryState {
  final String error;

  const HistoryError(this.error);

  @override
  List<Object> get props => [error];
}
