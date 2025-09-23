import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/home/data/model/tv_rated_model.dart';

void main() {
  group("TvRatedModel", () {

    test("should handle fromJson function to return a TvRatedModel", () {
      final mockJson = {
        "id": 1,
        "name": "Test TV Show",
        "original_name": "Test TV Show Original",
        "overview": "This is a test TV show",
        "poster_path": "/poster.jpg",
        "backdrop_path": "/backdrop.jpg",
        "media_type": "tv",
        "original_language": "en",
        "first_air_date": "2023-01-01",
        "adult": false,
        "popularity": 55.5,
        "vote_average": 7.8,
        "vote_count": 150,
        "genre_ids": [18, 35],
        "origin_country": ["US"],
      };

      final result = TvRatedModel.fromJson(mockJson);

      expect(result, isA<TvRatedModel>());
      expect(result.id, 1);
      expect(result.name, "Test TV Show");
      expect(result.originalName, "Test TV Show Original");
      expect(result.overview, "This is a test TV show");
      expect(result.posterPath, "/poster.jpg");
      expect(result.backdropPath, "/backdrop.jpg");
      expect(result.mediaType, "tv");
      expect(result.originalLanguage, "en");
      expect(result.firstAirDate, "2023-01-01");
      expect(result.adult, false);
      expect(result.popularity, 55.5);
      expect(result.voteAverage, 7.8);
      expect(result.voteCount, 150);
      expect(result.genreIds, equals([18, 35]));
      expect(result.originCountry, equals(["US"]));
    });

    test("should handle toJson function to return a Map<String, dynamic>", () {
      final tvRatedModel = TvRatedModel(
        id: 1,
        name: "Test TV Show",
        originalName: "Test TV Show Original",
        overview: "This is a test TV show",
        posterPath: "/poster.jpg",
        backdropPath: "/backdrop.jpg",
        mediaType: "tv",
        originalLanguage: "en",
        firstAirDate: "2023-01-01",
        adult: false,
        popularity: 55.5,
        voteAverage: 7.8,
        voteCount: 150,
        genreIds: [18, 35],
        originCountry: ["US"],
      );

      final result = tvRatedModel.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 1);
      expect(result['name'], "Test TV Show");
      expect(result['original_name'], "Test TV Show Original");
      expect(result['overview'], "This is a test TV show");
      expect(result['poster_path'], "/poster.jpg");
      expect(result['backdrop_path'], "/backdrop.jpg");
      expect(result['media_type'], "tv");
      expect(result['original_language'], "en");
      expect(result['first_air_date'], "2023-01-01");
      expect(result['adult'], false);
      expect(result['popularity'], 55.5);
      expect(result['vote_average'], 7.8);
      expect(result['vote_count'], 150);
      expect(result['genre_ids'], equals([18, 35]));
      expect(result['origin_country'], equals(["US"]));
    });

  });
}
