import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/remote/response/highlights/highlight_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IHighlightRepository extends IBaseRepository {
  Future<PaginatedResponse<Highlight>> getHighlights(
      {int page = 1, int limit = 10});
  Future<Highlight> getHighlight(String id);
  Future<Highlight> createHighlight(Highlight highlight);
  Future<Highlight> updateHighlight(Highlight highlight);
  Future<void> deleteHighlight(String id);
  Future<HighlightAnalytics> getHighlightAnalytics(String id);
}
