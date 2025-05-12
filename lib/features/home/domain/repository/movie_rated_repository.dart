import 'package:movie_app/features/home/domain/entities/movie_rated_entities.dart';

abstract class MovieRatedRepository {
  Future<List<MovieEntity>> getMovieRated();
  Future<MovieEntity> getMovieDetail(int movieId);
}