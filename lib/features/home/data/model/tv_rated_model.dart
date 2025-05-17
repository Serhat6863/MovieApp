import 'package:movie_app/features/home/domain/entities/tv_rated_entitties.dart';

class TvRatedModel extends TvEntity {
  TvRatedModel({
    required super.id,
    required super.name,
    required super.originalName,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.mediaType,
    required super.originalLanguage,
    required super.firstAirDate,
    required super.adult,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.genreIds,
    required super.originCountry,
  });

  factory TvRatedModel.fromJson(Map<String, dynamic> json) {
    return TvRatedModel(
      id: json['id'],
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      mediaType: json['media_type'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      adult: json['adult'] ?? false,
      popularity: (json['popularity'] ?? 0).toDouble(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'].map((x) => x))
          : [],
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'].map((x) => x))
          : [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'first_air_date': firstAirDate,
      'adult': adult,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
      'origin_country': List<dynamic>.from(originCountry.map((x) => x)),
    };
  }




}
