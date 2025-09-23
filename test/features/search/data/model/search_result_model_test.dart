import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/search/data/model/search_result_model.dart';

void main() {
  group("SearchResultModel", () {
    test("should handle fromJson function to return a SearchResultModel", () {
      final mockJson = {
        "id": 42,
        "title": "Test Search Result",
        "poster_path": "/poster.jpg",
        "backdrop_path": "/backdrop.jpg",
        "media_type": "movie",
      };

      final result = SearchResultModel.fromJson(mockJson);

      expect(result, isA<SearchResultModel>());
      expect(result.id, 42);
      expect(result.title, "Test Search Result");
      expect(result.posterPath, "/poster.jpg");
      expect(result.backdropPath, "/backdrop.jpg");
      expect(result.mediaType, "movie");
    });

    test("should handle toJson function to return a Map<String, dynamic>", () {
      const searchResultModel = SearchResultModel(
        id: 42,
        title: "Test Search Result",
        posterPath: "/poster.jpg",
        backdropPath: "/backdrop.jpg",
        mediaType: "movie",
      );

      final result = searchResultModel.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 42);
      expect(result['title'], "Test Search Result");
      expect(result['poster_path'], "/poster.jpg");
      expect(result['backdrop_path'], "/backdrop.jpg");
      expect(result['media_type'], "movie");
    });

    test("should handle missing fields gracefully in fromJson", () {
      final mockJson = {
        "id": 99,
        // title missing
        // poster_path missing
        "backdrop_path": null,
        "media_type": "tv",
      };

      final result = SearchResultModel.fromJson(mockJson);

      expect(result.id, 99);
      expect(result.title, ""); // default value
      expect(result.posterPath, ""); // default value
      expect(result.backdropPath, ""); // default because null
      expect(result.mediaType, "tv");
    });
  });
}
