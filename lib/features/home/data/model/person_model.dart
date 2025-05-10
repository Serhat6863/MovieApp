import 'package:movie_app/features/home/domain/entities/person_entities.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required super.id,
    required super.name,
    required super.originalName,
    required super.mediaType,
    required super.knownForDepartment,
    required super.profilePath,
    required super.adult,
    required super.gender,
    required super.popularity,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      mediaType: json['media_type'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      profilePath: json['profile_path'] ?? '',
      adult: json['adult'] ?? false,
      gender: json['gender'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'media_type': mediaType,
      'known_for_department': knownForDepartment,
      'profile_path': profilePath,
      'adult': adult,
      'gender': gender,
      'popularity': popularity,
    };
  }
}
