class PersonEntity {
  final int id;
  final String name;
  final String originalName;
  final String mediaType;
  final String knownForDepartment;
  final String profilePath;
  final bool adult;
  final int gender;
  final double popularity;

  PersonEntity({
    required this.id,
    required this.name,
    required this.originalName,
    required this.mediaType,
    required this.knownForDepartment,
    required this.profilePath,
    required this.adult,
    required this.gender,
    required this.popularity,
  });
}
