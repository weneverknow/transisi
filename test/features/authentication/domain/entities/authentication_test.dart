import 'package:flutter_test/flutter_test.dart';
import 'package:transisi/src/features/authentication/domain/entities/authentication.dart';

void main() {
  Authentication? auth1;
  Authentication? auth2;

  setUp(() {
    auth1 = const Authentication();
    auth2 = const Authentication();
  });

  test("Authentication class test", () {
    expect(auth1, isA<Authentication>());
    expect(auth1 == auth2, isTrue);
    expect(auth1?.token, isNull);
  });
}
