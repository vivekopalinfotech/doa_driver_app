
part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}


class GetHistory extends HistoryEvent {

  const GetHistory();

  @override
  List<Object> get props => [];
}

