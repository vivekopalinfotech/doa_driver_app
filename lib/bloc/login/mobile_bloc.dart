
import 'package:doa_driver_app/api/responses/mobile_rsponse.dart';
import 'package:doa_driver_app/repos/mobile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'mobile_event.dart';
part 'mobile_state.dart';

class MobileBloc extends Bloc<MobileEvent, MobileState> {
  final MobileRepo mobileRepo;

  MobileBloc(this.mobileRepo) : super(const MobileInitial());

  @override
  Stream<MobileState> mapEventToState(MobileEvent event) async* {
    if (event is PerformMobile) {
      try {
        final mobileResponse = await mobileRepo.phoneNo(event.mobile);
        if (mobileResponse.status == "Success") {
          yield MobileSuccess(mobileResponse.data);
        } else {
          yield MobileFailed(mobileResponse.status);
        }
      } on Error {
        yield const MobileFailed("Some Error");
      }
    }
  }
}
