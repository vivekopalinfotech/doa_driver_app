import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/repos/otp_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepo otpRepo;

  OtpBloc(this.otpRepo) : super(const OtpInitial());

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event is PerformLogin) {
      try {
        final otpResponse = await otpRepo.otp(event.mobile,event.code);
        if (otpResponse.status == "Success") {
          yield OtpSuccess(otpResponse.data);
        } else {
          yield OtpFailed(otpResponse.status);
        }
      } on Error {
        yield const OtpFailed("Some Error");
      }
    }
  }
}
