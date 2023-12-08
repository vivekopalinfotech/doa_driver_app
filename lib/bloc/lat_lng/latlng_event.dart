part of 'latlng_bloc.dart';



abstract class LatLngEvent extends Equatable {
  const LatLngEvent();
}

class UpdateLatLng extends LatLngEvent {
  String? id;
  String? latlng;
 
  UpdateLatLng(this.id,this.latlng);

  @override
  List<Object> get props => [id!,latlng!];
}
