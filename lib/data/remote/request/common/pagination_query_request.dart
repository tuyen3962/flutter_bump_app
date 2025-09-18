import 'package:json_annotation/json_annotation.dart';

part 'pagination_query_request.g.dart';

enum SortOrder {
  @JsonValue('asc')
  asc,
  @JsonValue('desc')
  desc,
}

@JsonSerializable()
class PaginationQueryRequest {
  final String? page;
  final String? limit;
  final String? query;
  final String? sortBy;
  final SortOrder sortOrder;

  PaginationQueryRequest({
    this.page,
    this.limit,
    this.query,
    this.sortBy,
    this.sortOrder = SortOrder.desc,
  });

  factory PaginationQueryRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationQueryRequestToJson(this);
}
