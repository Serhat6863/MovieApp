class RatedMovieEntities {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;


  const RatedMovieEntities({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });
}