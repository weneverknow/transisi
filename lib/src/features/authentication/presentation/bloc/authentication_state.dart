part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final Authentication auth;
  AuthenticationSuccess(this.auth);

  @override
  // TODO: implement props
  List<Object?> get props => [auth];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;
  final int timestamp;
  AuthenticationFailed(this.message, this.timestamp);

  @override
  // TODO: implement props
  List<Object?> get props => [message, timestamp];
}
