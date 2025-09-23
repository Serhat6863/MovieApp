import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/home/data/model/person_model.dart';

void main() {
  group("PersonModel", () {


    // First test to see if fromJson function returns a PersonModel
    test("should handle fromJson function to return a PersonModel", () {
      final mockJson = {
        "id": 1,
        "name": "Serhat",
        "profile_path": "/path/to/profile.jpg",
        "popularity": 10.0,
        "adult": false,
        "gender": 1,
        "media_type": "person",
        "original_name": "Serhat",
        "known_for_department": "Acting",
      };

      final result = PersonModel.fromJson(mockJson);

      expect(result, isA<PersonModel>());
      expect(result.id, 1);
      expect(result.name, "Serhat");
      expect(result.profilePath, "/path/to/profile.jpg");
      expect(result.popularity, 10.0);
      expect(result.adult, false);
      expect(result.gender, 1);
      expect(result.mediaType, "person");
      expect(result.originalName, "Serhat");
      expect(result.knownForDepartment, "Acting");
    });

    // Second test to see if toJson function returns a Map<String, dynamic>
    test("should handle toJson function to return a Map<String, dynamic>", () {
      final personModel = PersonModel(
        id: 1,
        name: "Serhat",
        originalName: "Serhat",
        mediaType: "person",
        knownForDepartment: "Acting",
        profilePath: "/path/to/profile.jpg",
        adult: false,
        gender: 1,
        popularity: 10.0,
      );

      final result = personModel.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 1);
      expect(result['name'], "Serhat");
      expect(result['profile_path'], "/path/to/profile.jpg");
      expect(result['popularity'], 10.0);
      expect(result['adult'], false);
      expect(result['gender'], 1);
      expect(result['media_type'], "person");
      expect(result['original_name'], "Serhat");
      expect(result['known_for_department'], "Acting");
    });

  });
}