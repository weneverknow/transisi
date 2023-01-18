import 'package:flutter_test/flutter_test.dart';
import 'package:transisi/src/features/authentication/data/model/authentication_model.dart';

var jsonResponse = {"token": DateTime.now().toIso8601String()};
void main() {
  AuthenticationModel? model1;
  AuthenticationModel? model2;

  setUp(() {
    model1 = const AuthenticationModel();
    model2 = AuthenticationModel.fromJson(jsonResponse);
  });

  group("AuthenticationModel test", () {
    test("initialized test", () {
      expect(model1, isA<AuthenticationModel>());
      expect(model1 == model2, isFalse);
      expect(model2?.token, equals(jsonResponse['token']));
    });
    test("fromJson test", () {
      expect(model1?.token, isNull);
      model1 = AuthenticationModel.fromJson(jsonResponse);
      expect(model1?.token, equals(jsonResponse['token']));
    });
  });
}
