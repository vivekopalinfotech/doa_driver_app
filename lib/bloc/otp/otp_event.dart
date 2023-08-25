
part of 'otp_bloc.dart';
abstract class OtpEvent extends Equatable {
  const OtpEvent();
}

class PerformLogin extends OtpEvent {
  final String mobile;
  final String code;

  const PerformLogin(this.mobile,this.code);

  @override
  List<Object> get props => [mobile,code];
}


