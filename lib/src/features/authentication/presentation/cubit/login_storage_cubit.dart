import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/src/core/usecase/usecase.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';
import 'package:transisi/src/features/authentication/domain/usecase/login_from_storage_use_case.dart';

class LoginStorageCubit extends Cubit<Authentication?> {
  LoginStorageCubit(
    this.loginFromStorageUseCase,
  ) : super(null);

  final LoginFromStorageUseCase loginFromStorageUseCase;

  checkLogin() async {
    final result = await loginFromStorageUseCase.call(NoParam());
    result.fold((l) => emit(null), (r) => emit(r));
  }
}
