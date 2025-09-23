import 'package:movie_app/features/search/data/api/search_result_api.dart';
import 'package:movie_app/features/search/data/model/search_result_model.dart';
import 'package:movie_app/features/search/domain/entity/search_result_entity.dart';
import 'package:movie_app/features/search/domain/repository/search_repository.dart';

import '../../../../core/constant.dart';

class SearchResultRepositoryImpl implements SearchRepository {
  final SearchResultApi searchResultApi;

  SearchResultRepositoryImpl({required this.searchResultApi});

  @override
  Future<List<SearchResultEntity>> searchMultiple(String query) async {
    try {
      final response = await searchResultApi.getSearchResult(
        query,
        "en-Us",
        1,
        true,
        "Bearer $kApiKey",
      );

      if (response.response.statusCode != 200) {
        throw Exception('Failed to load search result');
      }

      final data = response.data as Map<String, dynamic>;

      final List<SearchResultModel> results =
          (data['results'] as List)
              .map((result) => SearchResultModel.fromJson(result))
              .toList();

      return results;


    } catch (e) {
      throw Exception('Failed to load search result: $e');
    }
  }
}
