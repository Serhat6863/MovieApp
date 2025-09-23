class SearchResultEntity{
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String mediaType;


  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.mediaType,
  });
}