
part of 'online_bloc.dart';
abstract class OnlineEvent extends Equatable {
  const OnlineEvent();
}

class PerformOnline extends OnlineEvent {
  final String id;
  final String status;

  const PerformOnline(this.id,this.status);

  @override
  List<Object> get props => [id,status];
}


