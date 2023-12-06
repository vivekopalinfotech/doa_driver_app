import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/repos/update_shift_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'shift_event.dart';
part 'shift_state.dart';

class UpdateShiftBloc extends Bloc<UpdateShiftEvent, UpdateShiftState> {
  final UpdateShiftRepo updateShiftRepo;

  UpdateShiftBloc(this.updateShiftRepo) : super(const UpdateShiftInitial());

  @override
  Stream<UpdateShiftState> mapEventToState(UpdateShiftEvent event) async* {
    if (event is CheckUpdateShift) {
      try {
        final orderStatusResponse = await updateShiftRepo.updateShift(event.id, event.status, event.fcm_token);
        print(orderStatusResponse.status);
        if (orderStatusResponse.status == AppConstants.STATUS_SUCCESS ) {
          yield UpdateShiftSuccess(orderStatusResponse.message);
          yield const UpdateShiftInitial();
        } else {
          yield UpdateShiftFailed(orderStatusResponse.message);
          yield const UpdateShiftInitial();
        }

      } on Error {
        yield const UpdateShiftFailed("Some Error");
        yield const UpdateShiftInitial();
      }
    }
  }
}
