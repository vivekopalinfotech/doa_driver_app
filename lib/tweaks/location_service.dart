
import 'package:doa_driver_app/bloc/lat_lng/latlng_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

class LocationService with ChangeNotifier {
  final Location location = Location();
  LocationData? _currentLocation;

  LocationData? get currentLocation => _currentLocation;

  Future<void> startLocationService(BuildContext context) async {
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 60000,
      distanceFilter: 500.00
    );

    location.onLocationChanged.listen((LocationData locationData) {
      _currentLocation = locationData;
      BlocProvider.of<LatLngBloc>(context).add(UpdateLatLng(
        AppData.user!.id.toString(),
        "${_currentLocation!.latitude.toString()},${_currentLocation!.longitude.toString()}",
      ));
    });
  }

}
