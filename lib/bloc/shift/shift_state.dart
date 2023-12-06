
part of 'shift_bloc.dart';

abstract class UpdateShiftState extends Equatable {
  const UpdateShiftState();
}

class UpdateShiftInitial extends UpdateShiftState {
  const UpdateShiftInitial();

  @override
  List<Object> get props => [];
}


class UpdateShiftSuccess extends UpdateShiftState {
  final String? message;

  const UpdateShiftSuccess(this.message);

  @override
  List<Object> get props => [message!];
}



class UpdateShiftFailed extends UpdateShiftState {
  final String? message;

  const UpdateShiftFailed(this.message);

  @override
  List<Object> get props => [message!];
}

class UpdateShiftLoading extends UpdateShiftState {
  const UpdateShiftLoading();

  @override
  List<Object> get props => [];
}