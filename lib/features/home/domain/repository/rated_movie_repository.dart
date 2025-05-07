import 'package:movie_app/features/home/domain/entities/rated_movie_entities.dart';

abstract class RatedMovieRepository{
  Future<List<RatedMovieEntities>> getRatedMovies();

}