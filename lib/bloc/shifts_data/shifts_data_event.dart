


import 'package:equatable/equatable.dart';

abstract class ShiftsDataEvent extends Equatable {
  const ShiftsDataEvent();
}


class GetShiftsData extends ShiftsDataEvent {
  int? id;
  GetShiftsData(this.id);

  @override
  List<Object> get props => [id!];
}

