import 'package:movie_app/features/home/domain/entities/rated_movie_entities.dart';

class RatedMovieModel extends RatedMovieEntities{

  const RatedMovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.voteAverage,
  });

  factory RatedMovieModel.fromJson(Map<String, dynamic> json) {
    return RatedMovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'vote_average': voteAverage,
    };
  }

}