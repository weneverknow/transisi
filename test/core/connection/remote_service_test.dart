import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transisi/src/core/connection/remote_service.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([MockSpec<RemoteService>()])
import 'remote_service_test.mocks.dart';

var jsonResponse = {"token": "indonesia"};

void main() {
  test("remote service test", () async {
    var remote = MockRemoteService();
    when(remote.post("$apiurl/login"))
        .thenAnswer((realInvocation) async => http.Response(
              jsonEncode(jsonResponse),
              200,
              headers: {"Content-Type": "application/json"},
            ));

    final response = await remote.post("$apiurl/login");
    expect(response, isA<http.Response>());
  });
}
