class ErrorException implements Exception {
  final dynamic message;
  final String? error;
  final int? statusCode;

  ErrorException({required this.message, this.error, this.statusCode});

  factory ErrorException.fromJson(Map<String, dynamic> json) {
    return ErrorException(
      message: json['message'],
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }
}
