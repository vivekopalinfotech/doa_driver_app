part of 'delivery_update_bloc.dart';

abstract class DeliveryUpdateState extends Equatable {
  const DeliveryUpdateState();
}

class DeliveryUpdateInitial extends DeliveryUpdateState {
  const DeliveryUpdateInitial();

  @override
  List<Object> get props => [];
}

class DeliveryUpdateLoading extends DeliveryUpdateState {
  const DeliveryUpdateLoading();

  @override
  List<Object> get props => [];
}

class DeliveryUpdateLoaded extends DeliveryUpdateState {
  final DeliveryUpdateResponse deliveryUpdateResponse;

  const DeliveryUpdateLoaded(this.deliveryUpdateResponse);

  @override
  List<Object> get props => [deliveryUpdateResponse];
}


class DeliveryUpdateError extends DeliveryUpdateState {
  final String error;

  const DeliveryUpdateError(this.error);

  @override
  List<Object> get props => [error];
}
