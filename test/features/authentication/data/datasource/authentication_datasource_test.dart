import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:transisi/src/features/authentication/data/model/authentication_model.dart';
import '../../../../core/connection/remote_service_test.mocks.dart';
import 'authentication_datasource_test.mocks.dart';

var jsonResponse = {"token": "indonesia"};

void main() {
  late MockRemoteService remote;

  late MockAuthenticationDatasource datasource;

  setUp(() {
    remote = MockRemoteService();

    datasource = MockAuthenticationDatasource();
  });
  setupRemoteServiceRequest() {
    when(remote.post("$apiurl/login"))
        .thenAnswer((realInvocation) async => http.Response(
              jsonEncode(jsonResponse),
              200,
              headers: {"Content-Type": "application/json"},
            ));
  }

  setupAuthenticationDatasourceLogin() {
    when(datasource.login(email: "eve.holt@reqres.i", password: "cityslicka"))
        .thenAnswer((realInvocation) async =>
            AuthenticationModel.fromJson(jsonResponse));
  }

  group("Authentication data source test", () {
    test("remote service test", () async {
      //arrange
      setupRemoteServiceRequest();

      //act
      remote.post("$apiurl/login");

      //assert
      verify(remote.post("$apiurl/login"));
    });

    test("login test and its result", () async {
      //arrange
      setupAuthenticationDatasourceLogin();

      //act
      final response = await datasource.login(
          email: "eve.holt@reqres.i", password: "cityslicka");

      //expect
      expect(response, isA<AuthenticationModel>());
      expect(response.token, isNotNull);
      expect(response.token, equals(jsonResponse['token']));
    });
  });
}
