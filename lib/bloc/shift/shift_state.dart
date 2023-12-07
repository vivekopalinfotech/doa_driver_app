
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
  final LoginResponse updateShiftResponse;

  const UpdateShiftSuccess(this.updateShiftResponse);

  @override
  List<Object> get props => [updateShiftResponse];
}



class UpdateShiftFailed extends UpdateShiftState {
  final LoginResponse updateShiftResponse;

  const UpdateShiftFailed(this.updateShiftResponse);

  @override
  List<Object> get props => [updateShiftResponse];
}

class UpdateShiftLoading extends UpdateShiftState {
  const UpdateShiftLoading();

  @override
  List<Object> get props => [];
}