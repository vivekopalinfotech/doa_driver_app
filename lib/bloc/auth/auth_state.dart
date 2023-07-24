part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User? user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user!];
}

class UnAuthenticated extends AuthState {
  const UnAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState {
  final String? message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [message!];
}

class EmailSent extends AuthState {

  final String? message;

  const EmailSent(this.message);

  @override
  List<Object> get props => [message!];
}