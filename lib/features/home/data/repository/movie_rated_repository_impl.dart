import 'package:movie_app/core/constant.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:movie_app/features/home/domain/entities/movie_rated_entities.dart';
import 'package:movie_app/features/home/domain/repository/movie_rated_repository.dart';

import '../api/movie_rated_api.dart';

class MovieRatedRepositoryImpl implements MovieRatedRepository{

  final MovieRatedApi movieRatedApi;

  MovieRatedRepositoryImpl({required this.movieRatedApi});


  @override
  Future<List<MovieEntity>> getMovieRated() async{
    try{
      final response = await movieRatedApi.getMovieRated('en-US', "Bearer $kApiKey", 'day');


      if(response.response.statusCode != 200){
        throw Exception('Failed to load movie rated');
      }

      return response.data!.map((movie) => MovieRatedModel.fromJson(movie.toJson())).toList();

    }catch(e){
      throw Exception('Failed to load movie rated: $e');
    }
  }

}