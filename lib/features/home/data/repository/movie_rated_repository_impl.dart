import 'package:movie_app/core/constant.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:movie_app/features/home/domain/entities/movie_rated_entities.dart';
import 'package:movie_app/features/home/domain/repository/movie_rated_repository.dart';

import '../api/media_api.dart';

class MovieRatedRepositoryImpl implements MovieRatedRepository {
  final MediaApi mediaApi;

  MovieRatedRepositoryImpl({required this.mediaApi});

  @override
  Future<List<MovieEntity>> getMovieRated() async {
    try {
      final response = await mediaApi.getMovieRated(
        'en-US',
        "Bearer $kApiKey",
        'day',
      );

      if (response.response.statusCode != 200) {
        throw Exception('Failed to load movie rated');
      }

      final data = response.data as Map<String, dynamic>;

      final List<MovieRatedModel> results =
          (data['results'] as List)
              .map((movie) => MovieRatedModel.fromJson(movie))
              .toList();

      return results;
    } catch (e) {
      throw Exception('Failed to load movie rated: $e');
    }
  }
}
