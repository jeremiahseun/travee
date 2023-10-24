sealed class APIException implements Exception {
  final String message;
  APIException(this.message);
}

class NoInternetConnectionException implements APIException {
  @override
  String get message => "No internet connection";
  @override
  String toString() {
    return 'NoInternetConnectionException: $message';
  }
}

class NotFoundException implements APIException {
  @override
  String get message => "Not found!";

  @override
  String toString() {
    return 'NotFoundException: $message';
  }
}

class InvalidCredentialsException implements APIException {
  InvalidCredentialsException({this.errorMessage});
  final String? errorMessage;
  @override
  String get message => errorMessage ?? "Invalid credentials";
  @override
  String toString() {
    return 'InvalidCredentialsException: $message';
  }
}

class UserAlreadyExistsException implements APIException {
  UserAlreadyExistsException();
  @override
  String get message => "User already exists!";
  @override
  String toString() {
    return 'UserAlreadyExistsException: $message';
  }
}

class UnknownException implements APIException {
  @override
  String get message => "Some error occured!";
  @override
  String toString() {
    return 'UnknownException: $message';
  }
}
