import 'package:movie_app/features/home/domain/entities/tv_rated_entitties.dart';

abstract class TvRatedRepository{
  Future<List<TvEntity>> getTvRated();
}