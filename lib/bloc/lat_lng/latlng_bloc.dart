


import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/repos/updatelatlng_repo.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



part 'latlng_event.dart';

part 'latlng_state.dart';

class LatLngBloc extends Bloc<LatLngEvent, LatLngState> {
  final LatLngRepo latLngRepo;

  LatLngBloc(this.latLngRepo) : super(const LatLngInitial());

  @override
  Stream<LatLngState> mapEventToState(LatLngEvent event) async* {
    if (event is UpdateLatLng) {
      try {
        final latLngResponse = await latLngRepo.updateLatLng(event.id!,event.latlng!);
        if (latLngResponse.isNotEmpty) {
          yield LatLngLoaded(latLngResponse);
        } else {
          yield LatLngError('Error');
        }
      } on Error {
        yield const LatLngError("Couldn't fetch weather. Is the device online?");
      }
    }

  }
}
