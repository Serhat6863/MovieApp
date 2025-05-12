import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constant.dart';

part 'media_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MediaApi {
  factory MediaApi(Dio dio) = _MediaApi;

  @GET("/trending/movie/{time_window}")
  Future<HttpResponse<dynamic>> getMovieRated(
    @Query("language") String language,
    @Header("Authorization") String apiKey,
    @Path("time_window") String timeWindow,
  );

  @GET("/movie/{movie_id}")
  Future<HttpResponse<MovieRatedModel>> getMovieDetail(
    @Path("movie_id") int movieId,
    @Header("Authorization") String apiKey,
  );

  @GET("/trending/tv/{time_window}")
  Future<HttpResponse<dynamic>> getTvRated(
    @Query("language") String language,
    @Header("Authorization") String apiKey,
    @Path("time_window") String timeWindow,
  );

  @GET("/trending/person/{time_window}")
  Future<HttpResponse<dynamic>> getPerson(
    @Query("language") String language,
    @Header("Authorization") String apiKey,
    @Path("time_window") String timeWindow,
  );
}
