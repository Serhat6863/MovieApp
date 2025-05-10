class TvEntity {
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String mediaType;
  final String originalLanguage;
  final String firstAirDate;
  final bool adult;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final List<String> originCountry;

  TvEntity({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.firstAirDate,
    required this.adult,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.originCountry,
  });
}
