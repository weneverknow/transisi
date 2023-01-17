import '/src/features/authentication/domain/entities/authentication.dart';

class AuthenticationModel extends Authentication {
  const AuthenticationModel({String? token})
      : super(
          token: token,
        );

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(token: json['token']);
}
