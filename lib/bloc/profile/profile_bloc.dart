


import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/repos/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo profileRepo;

  ProfileBloc(this.profileRepo) : super(const ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfile) {
      try {
        final profileResponse = await profileRepo.updateProfile(event.id!,event.vehicleNo!,event.vehicleColor!,event.firstName!,event.lastName!,event.code!);
        if (profileResponse.status == AppConstants.STATUS_SUCCESS ) {
          yield ProfileLoaded(profileResponse.data);
        } else {
          yield ProfileError('Error');
        }
      } on Error {
        yield const ProfileError("Couldn't fetch weather. Is the device online?");
      }
    }

  }
}
