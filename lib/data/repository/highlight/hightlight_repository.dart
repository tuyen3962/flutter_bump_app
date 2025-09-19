import 'package:flutter_bump_app/data/remote/response/base_response.dart';

import 'package:flutter_bump_app/data/remote/response/highlights/highlight_response.dart';
import 'package:injectable/injectable.dart';

import 'ihightlight_repository.dart';
import 'package:flutter_bump_app/data/remote/highlight_api.dart';

@Injectable(as: IHighlightRepository)
class HighlightRepository extends IHighlightRepository {
  final HighlightApi highlightApi;

  HighlightRepository(this.highlightApi);

  @override
  Future<Highlight> createHighlight(Highlight highlight) {
    // TODO: implement createHighlight
    throw UnimplementedError();
  }

  @override
  Future<void> deleteHighlight(String id) {
    // TODO: implement deleteHighlight
    throw UnimplementedError();
  }

  @override
  Future<Highlight> getHighlight(String id) async {
    try {
      final response = await highlightApi.getHighlight(id);
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<HighlightAnalytics> getHighlightAnalytics(String id) async {
    try {
      final response = await highlightApi.getHighlightAnalytics(id);
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PaginatedResponse<Highlight>> getHighlights(
      {int page = 1, int limit = 10}) async {
    try {
      final response =
          await highlightApi.getHighlights({'page': page, 'limit': limit});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Highlight> updateHighlight(Highlight highlight) {
    // TODO: implement updateHighlight
    throw UnimplementedError();
  }
}
