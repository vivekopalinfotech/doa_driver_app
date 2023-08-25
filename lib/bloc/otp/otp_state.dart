
part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();
}

class OtpInitial extends OtpState {
  const OtpInitial();

  @override
  List<Object> get props => [];
}


class OtpSuccess extends OtpState {
  final User? user;

  const OtpSuccess(this.user);

  @override
  List<Object> get props => [user!];
}



class OtpFailed extends OtpState {
  final String? message;

  const OtpFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}
