import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constant.dart';

part 'movie_rated_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MovieRatedApi {
  factory MovieRatedApi(Dio dio) = _MovieRatedApi;

  @GET("/trending/movie/{time_window}")
  Future<HttpResponse<List<MovieRatedModel>>> getMovieRated(
    @Query("language") String language,
    @Header("Authorization") String apiKey,
    @Path("time_window") String timeWindow,
  );
}
