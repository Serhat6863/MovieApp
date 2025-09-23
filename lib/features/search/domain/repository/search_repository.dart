import 'package:movie_app/features/search/domain/entity/search_result_entity.dart';

abstract class SearchRepository {
  Future<List<SearchResultEntity>> searchMultiple(String query);
}