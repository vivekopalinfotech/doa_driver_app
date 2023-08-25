import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/repos/history_repo.dart';
import 'package:doa_driver_app/repos/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepo historyRepo;

  HistoryBloc(this.historyRepo) : super(const HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is GetHistory) {
      try {
        final ordersResponse = await historyRepo.getHistory();
        if (ordersResponse.status == AppConstants.STATUS_SUCCESS &&
            ordersResponse.data != null) {
          yield HistoryLoaded(ordersResponse.data!);
        } else {
          yield HistoryError(ordersResponse.message!);
        }
      } on Error {
        yield const HistoryError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
