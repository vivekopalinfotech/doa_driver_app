
part of 'shift_bloc.dart';
abstract class UpdateShiftEvent extends Equatable {
  const UpdateShiftEvent();
}

class CheckUpdateShift extends UpdateShiftEvent {
  final int id;
  final int status;
  final String fcm_token;

  const CheckUpdateShift(this.id,this.status, this.fcm_token);

  @override
  List<Object> get props => [id,status];
}


