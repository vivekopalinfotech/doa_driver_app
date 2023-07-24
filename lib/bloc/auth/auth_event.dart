part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class PerformLogin extends AuthEvent {
  final String email;
  final String password;

  const PerformLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}



class PerformLogout extends AuthEvent {
  const PerformLogout();

  @override
  List<Object> get props => [];
}

class PerformAutoLogin extends AuthEvent {
  final User user;

  const PerformAutoLogin(this.user);

  @override
  List<Object> get props => [user];
}


