import 'package:movie_app/features/search/domain/entity/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity{

  const SearchResultModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.backdropPath,
    required super.mediaType,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'],
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      mediaType: json['media_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'media_type': mediaType,
    };
  }
}