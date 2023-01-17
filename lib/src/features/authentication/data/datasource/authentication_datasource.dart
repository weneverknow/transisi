import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:transisi/src/core/connection/remote_service.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:transisi/src/core/exceptions/exceptions.dart';
import 'package:transisi/src/features/authentication/data/model/authentication_model.dart';

abstract class AuthenticationDatasource {
  Future<AuthenticationModel> login({
    required String email,
    required String password,
  });

  Future<String?> loginFromStorage();
}

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final RemoteService remoteService;
  AuthenticationDatasourceImpl(this.remoteService);

  @override
  Future<AuthenticationModel> login(
      {required String email, required String password}) async {
    var body = {
      "email": email,
      "password": password,
    };
    final response = await remoteService.post(
      "$apiurl/login",
      body: body,
    );

    if (response.statusCode != 200) {
      throw AuthenticationErrorException(jsonDecode(response.body)['error']);
    }
    var data = jsonDecode(response.body);

    await _saveTokenToLocalStorage(data['token']);
    return AuthenticationModel.fromJson(data);
  }

  @override
  Future<String?> loginFromStorage() async {
    final token = await getTokenFromLocalStorage();
    return token;
  }

  Future<void> _saveTokenToLocalStorage(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  Future<String?> getTokenFromLocalStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }
}
