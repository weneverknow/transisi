part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationUserLogin extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationUserLogin({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
