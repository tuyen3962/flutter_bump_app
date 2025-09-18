import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Base response class for all API responses
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final bool? success;
  final String? message;
  final T? data;
  final String? deviceId;

  BaseResponse({
    this.success,
    this.message,
    this.data,
    this.deviceId,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

/// Pagination metadata for list responses
@JsonSerializable()
class PaginationMeta {
  final int totalPages;
  final int totalItems;
  final bool canNext;
  final bool canPrev;
  final int currentPage;
  final int limit;

  PaginationMeta({
    required this.totalPages,
    required this.totalItems,
    required this.canNext,
    required this.canPrev,
    required this.currentPage,
    required this.limit,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}

/// Base paginated response for list APIs
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> data;
  @JsonKey(name: 'paginate')
  final PaginationMeta pagination;

  PaginatedResponse({
    required this.data,
    required this.pagination,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

/// Error response structure
@JsonSerializable()
class ErrorResponse {
  final int statusCode;
  final String timestamp;
  final String path;
  final String method;
  final dynamic message;
  final String? error;
  final Map<String, dynamic>? details;
  final String? requestId;

  ErrorResponse({
    required this.statusCode,
    required this.timestamp,
    required this.path,
    required this.method,
    required this.message,
    this.error,
    this.details,
    this.requestId,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
