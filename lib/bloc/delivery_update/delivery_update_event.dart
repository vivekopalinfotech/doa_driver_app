
part of 'delivery_update_bloc.dart';

abstract class DeliveryUpdateEvent extends Equatable {
  const DeliveryUpdateEvent();
}


class GetDeliveryUpdate extends DeliveryUpdateEvent {

  const GetDeliveryUpdate();

  @override
  List<Object> get props => [];
}

