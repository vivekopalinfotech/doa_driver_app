part of 'latlng_bloc.dart';

abstract class LatLngState extends Equatable {
  const LatLngState();
}

class LatLngInitial extends LatLngState {
  const LatLngInitial();

  @override
  List<Object> get props => [];
}

class LatLngLoading extends LatLngState {
  const LatLngLoading();

  @override
  List<Object> get props => [];
}

class LatLngLoaded extends LatLngState {
  final String user;

  const LatLngLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LatLngError extends LatLngState {
  final String error;

  const LatLngError(this.error);

  @override
  List<Object> get props => [error];
}
