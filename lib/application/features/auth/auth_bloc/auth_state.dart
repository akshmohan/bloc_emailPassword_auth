part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  User user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthenticatedError extends AuthState {
  final String error;

  AuthenticatedError({required this.error});
}
