part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class UpdateProfile extends ProfileEvent {
  String? id;
  String? vehicleNo;
  String? vehicleColor;
  String? firstName;
  String? lastName;
  String? code;
  UpdateProfile(this.id,this.vehicleNo,this.vehicleColor,this.firstName,this.lastName,this.code);

  @override
  List<Object> get props => [id!,vehicleNo!,vehicleColor!,firstName!,lastName!,code!];
}
