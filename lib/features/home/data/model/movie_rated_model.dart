import 'package:movie_app/features/home/domain/entities/movie_rated_entities.dart';

class MovieRatedModel extends MovieEntity{

  MovieRatedModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.originalLanguage,
    required super.mediaType,
    required super.releaseDate,
    required super.genreIds,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.adult,
    required super.video,
  });

  factory MovieRatedModel.fromJson(Map<String, dynamic> json) {
    return MovieRatedModel(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      mediaType: json['media_type'],
      releaseDate: json['release_date'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      popularity: json['popularity'].toDouble(),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'media_type': mediaType,
      'release_date': releaseDate,
      'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'video': video,
    };
  }
}