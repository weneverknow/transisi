import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';
import 'package:transisi/src/features/authentication/domain/usecase/login_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.loginUseCase,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthenticationUserLogin>(_login);
  }

  final LoginUseCase loginUseCase;

  Future<void> _login(
      AuthenticationUserLogin event, Emitter<AuthenticationState> emit) async {
    final result = await loginUseCase
        .call(LoginParam(email: event.email, password: event.password));
    result.fold(
        (l) => emit(AuthenticationFailed(
            l.message, DateTime.now().millisecondsSinceEpoch)),
        (r) => emit(AuthenticationSuccess(r)));
  }
}
