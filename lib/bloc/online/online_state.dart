
part of 'online_bloc.dart';

abstract class OnlineState extends Equatable {
  const OnlineState();
}

class OnlineInitial extends OnlineState {
  const OnlineInitial();

  @override
  List<Object> get props => [];
}


class OnlineSuccess extends OnlineState {
  final String? message;

  const OnlineSuccess(this.message);

  @override
  List<Object> get props => [message!];
}



class OnlineFailed extends OnlineState {
  final String? message;

  const OnlineFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}
