
part of 'mobile_bloc.dart';

abstract class MobileState extends Equatable {
  const MobileState();
}

class MobileInitial extends MobileState {
  const MobileInitial();

  @override
  List<Object> get props => [];
}


class MobileSuccess extends MobileState {
  final Data? data;

  const MobileSuccess(this.data);

  @override
  List<Object> get props => [data!];
}



class MobileFailed extends MobileState {
  final String? message;

  const MobileFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}
