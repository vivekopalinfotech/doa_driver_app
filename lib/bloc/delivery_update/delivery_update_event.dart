
part of 'delivery_update_bloc.dart';

abstract class DeliveryUpdateEvent extends Equatable {
  const DeliveryUpdateEvent();
}


class GetDeliveryUpdate extends DeliveryUpdateEvent {
  int? id;
   GetDeliveryUpdate(this.id);

  @override
  List<Object> get props => [id!];
}

