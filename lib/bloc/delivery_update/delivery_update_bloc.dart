import 'package:doa_driver_app/api/responses/delivery_update_response.dart';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/repos/history_repo.dart';
import 'package:doa_driver_app/repos/update_delivery.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_update_event.dart';

part 'delivery_update_state.dart';

class DeliveryUpdateBloc extends Bloc<DeliveryUpdateEvent, DeliveryUpdateState> {
  final DeliveryUpdateRepo deliveryUpdateRepo;

  DeliveryUpdateBloc(this.deliveryUpdateRepo) : super(const DeliveryUpdateInitial());

  @override
  Stream<DeliveryUpdateState> mapEventToState(DeliveryUpdateEvent event) async* {
    if (event is GetDeliveryUpdate) {
      try {
        final deliveryUpdateResponse = await deliveryUpdateRepo.getDeliveryUpdate();
        if (deliveryUpdateResponse.status == AppConstants.STATUS_SUCCESS ) {
          yield DeliveryUpdateLoaded(deliveryUpdateResponse);
        } else {
          yield DeliveryUpdateError('error');
        }
      } on Error {
        yield const DeliveryUpdateError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
