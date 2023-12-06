import 'package:doa_driver_app/bloc/shifts_data/shifts_data_event.dart';
import 'package:doa_driver_app/bloc/shifts_data/shifts_data_state.dart';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/repos/shifts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShiftsDataBloc extends Bloc<ShiftsDataEvent, ShiftsDataState> {
  final ShiftsRepo shiftsRepo;

  ShiftsDataBloc(this.shiftsRepo) : super(const ShiftsDataInitial());

  @override
  Stream<ShiftsDataState> mapEventToState(ShiftsDataEvent event) async* {
    if (event is GetShiftsData) {
      try {
        final shiftsDataResponse = await shiftsRepo.getShiftsData(event.id!);
        if (shiftsDataResponse.status == AppConstants.STATUS_SUCCESS &&
            shiftsDataResponse.data != null) {
          yield ShiftsDataLoaded(shiftsDataResponse);
        } else {
          yield const ShiftsDataError('Error');
        }
      } on Error {
        yield const ShiftsDataError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
