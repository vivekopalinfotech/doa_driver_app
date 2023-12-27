import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/repos/auth_repo.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(const AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PerformLogin) {
      try {
        final loginResponse =
        await authRepo.loginUser(event.email, event.password);
        if (loginResponse.status == AppConstants.STATUS_SUCCESS &&
            loginResponse.data != null) {
          yield Authenticated(loginResponse.data!);
        } else {
          yield AuthFailed("Some Error");
        }
      } on Error {
        yield const AuthFailed("Some Error");
      }
    }  else if (event is PerformLogout) {
      try {
        final logoutResponse = await authRepo.logoutUser();
        if (logoutResponse.message == 'Unauthenticated.') {
          AppData.user = null;
          final sharedPrefService = await SharedPreferencesService.instance;
          sharedPrefService.logoutUser();

          yield const UnAuthenticated();
        } else {
          yield AuthFailed(logoutResponse.message!);
        }
      } on Error {
        yield const AuthFailed("Some error");
      }
    } else if (event is PerformAutoLogin) {
      yield Authenticated(event.user);
    }
  }
}
