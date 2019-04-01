class UnauthorizedException implements Exception {
  String message;
  UnauthorizedException(this.message);
  @override
  String toString() {
    return 'UnauthorizedException{message: $message}';
  }
}

class NotFoundException implements Exception {
  String message;
  NotFoundException(this.message);
  @override
  String toString() {
    return 'NotFoundException{message: $message}';
  }
}

class BadResponseException implements Exception {
  String message;
  BadResponseException(this.message);
  @override
  String toString() {
    return 'BadResponseException{message: $message}';
  }
}
