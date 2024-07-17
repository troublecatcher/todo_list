class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = 'Unauthorized request']);

  @override
  String toString() => 'UnauthorizedException: $message';
}
