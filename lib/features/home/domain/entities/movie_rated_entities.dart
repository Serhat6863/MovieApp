class MovieEntity{
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String originalLanguage;
  final String mediaType;
  final String releaseDate;
  final List<int> genreIds;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final bool video;


  MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.originalLanguage,
    required this.mediaType,
    required this.releaseDate,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.video,
  });


}