

import 'package:doa_driver_app/api/responses/shifts_data_response.dart';
import 'package:equatable/equatable.dart';

abstract class ShiftsDataState extends Equatable {
  const ShiftsDataState();
}

class ShiftsDataInitial extends ShiftsDataState {
  const ShiftsDataInitial();

  @override
  List<Object> get props => [];
}

class ShiftsDataLoading extends ShiftsDataState {
  const ShiftsDataLoading();

  @override
  List<Object> get props => [];
}

class ShiftsDataLoaded extends ShiftsDataState {
  final ShiftsDataResponse shiftsDataResponse;

  const ShiftsDataLoaded(this.shiftsDataResponse);

  @override
  List<Object> get props => [shiftsDataResponse];
}


class ShiftsDataError extends ShiftsDataState {
  final String error;

  const ShiftsDataError(this.error);

  @override
  List<Object> get props => [error];
}
