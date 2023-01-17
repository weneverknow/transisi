abstract class Exceptions implements Exception {}

class DatabaseException implements Exceptions {
  final String message;
  DatabaseException(this.message);
}

class ValidationException implements Exceptions {
  final String message;
  ValidationException(this.message);
}

class FirebaseAuthenticationException implements Exceptions {
  final String message;
  FirebaseAuthenticationException(this.message);
}

class CurrentLocationException implements Exceptions {
  final String message;
  CurrentLocationException(this.message);
}

class HttpErrorException implements Exceptions {
  final String message;
  HttpErrorException(this.message);
}

class AuthenticationErrorException implements Exceptions {
  final String message;
  AuthenticationErrorException(this.message);
}

class DataNotFoundException implements Exceptions {
  final String message;
  DataNotFoundException(this.message);
}
