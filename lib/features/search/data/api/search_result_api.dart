
import 'package:dio/dio.dart';
import 'package:movie_app/core/constant.dart';
import 'package:retrofit/retrofit.dart';

part 'search_result_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class SearchResultApi {
  factory SearchResultApi(Dio dio, {String baseUrl}) = _SearchResultApi;

  @GET("/search/multi")
  Future<HttpResponse<dynamic>> getSearchResult(
    @Query("query") String query,
    @Query("language") String language,
    @Query("page") int page,
    @Query("include_adult") bool includeAdult,
    @Header("Authorization") String apiKey,
  );


}