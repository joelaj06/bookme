

class AppException implements Exception {

  AppException(this.message, this.prefix, this.url);
  String message;
  String prefix;
  String url;
}

class BadRequestException extends AppException {
  BadRequestException(String message,  String url)
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException(String message,  String url)
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException(String message,  String url)
      : super(message, 'Api Not Responding', url);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message,  String url)
      : super(message, 'Unauthorized Request', url);
}


