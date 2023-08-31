
part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}


class GetHistory extends HistoryEvent {
  int? id;
   GetHistory(this.id);

  @override
  List<Object> get props => [id!];
}

