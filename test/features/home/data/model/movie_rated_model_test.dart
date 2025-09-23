import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';

void main(){
  group("movieRatedModel", (){


    //first test to see if fromJson function returns a MovieRatedModel
    test("should handle fromJson function to returns a MovieRatedModel", (){

      final mockJson = {
        "id": 1,
        "title": "Test Movie",
        "overview": "This is a test movie",
        "poster_path": "/test.jpg",
        "vote_average": 8.5,
        "release_date": "2023-01-01",
        "backdrop_path": "/backdrop.jpg",
        "original_language": "en",
        "original_title": "Test Movie Original",
        "media_type": "movie",
        "genre_ids": [1, 2, 3],
        "popularity": 100.0,
        "vote_count": 200,
        "adult": false,
        "video": false,
      };

      final result = MovieRatedModel.fromJson(mockJson);

      expect(result, isA<MovieRatedModel>());
      expect(result.id, 1);
      expect(result.title, 'Test Movie');
      expect(result.overview, 'This is a test movie');
      expect(result.posterPath, '/test.jpg');
      expect(result.voteAverage, 8.5);
      expect(result.releaseDate, '2023-01-01');
      expect(result.backdropPath, '/backdrop.jpg');
      expect(result.originalLanguage, 'en');
      expect(result.originalTitle, 'Test Movie Original');
      expect(result.mediaType, 'movie');
      expect(result.genreIds, [1, 2, 3]);
      expect(result.popularity, 100.0);
      expect(result.voteCount, 200);
      expect(result.adult, false);
      expect(result.video, false);
    });

    // second test to see if toJson function returns a Map<String, dynamic>
    test("should handle toJson function to returns a Map<String, dynamic>", (){

      final movieRatedModel = MovieRatedModel(
        id: 1,
        title: "Test Movie",
        overview: "This is a test movie",
        posterPath: "/test.jpg",
        voteAverage: 8.5,
        releaseDate: "2023-01-01",
        backdropPath: "/backdrop.jpg",
        originalLanguage: "en",
        originalTitle: "Test Movie Original",
        mediaType: "movie",
        genreIds: [1, 2, 3],
        popularity: 100.0,
        voteCount: 200,
        adult: false,
        video: false,
      );

      final result = movieRatedModel.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 1);
      expect(result['title'], 'Test Movie');
      expect(result['overview'], 'This is a test movie');
      expect(result['poster_path'], '/test.jpg');
      expect(result['vote_average'], 8.5);
      expect(result['release_date'], '2023-01-01');
      expect(result['backdrop_path'], '/backdrop.jpg');
      expect(result['original_language'], 'en');
      expect(result['original_title'], 'Test Movie Original');
      expect(result['media_type'], 'movie');
      expect(result['genre_ids'], [1, 2, 3]);
      expect(result['popularity'], 100.0);
      expect(result['vote_count'], 200);
      expect(result['adult'], false);
      expect(result['video'], false);
    });

    // third test to see if null values are handled correctly in fromJson
    test("should handle null values in fromJson function", () {
      final mockJson = {
        "id": 1,
        // "title" is null
        "overview": null,
        "poster_path": null,
        "vote_average": null,
        "release_date": null,
        "backdrop_path": null,
        "original_language": null,
        "original_title": null,
        "media_type": null,
        "genre_ids": null,
        "popularity": null,
        "vote_count": null,
        "adult": null,
        "video": null,
      };

      final result = MovieRatedModel.fromJson(mockJson);

      expect(result, isA<MovieRatedModel>());
      expect(result.id, 1);
      expect(result.title, '');
      expect(result.overview, '');
      expect(result.posterPath, '');
      expect(result.voteAverage, 0.0);
      expect(result.releaseDate, '');
      expect(result.backdropPath, '');
      expect(result.originalLanguage, '');
      expect(result.originalTitle, '');
      expect(result.mediaType, '');
      expect(result.genreIds, []);
      expect(result.popularity, 0.0);
      expect(result.voteCount, 0);
      expect(result.adult, false);
      expect(result.video, false);
    });


    // fourth test to see if empty genre_ids are handled correctly in fromJson
    test("should handle empty genre_ids in fromJson function", () {
      final mockJson = {
        "id": 1,
        "title": "Test Movie",
        "overview": "This is a test movie",
        "poster_path": "/test.jpg",
        "vote_average": 8.5,
        "release_date": "2023-01-01",
        "backdrop_path": "/backdrop.jpg",
        "original_language": "en",
        "original_title": "Test Movie Original",
        "media_type": "movie",
        "genre_ids": [],
        "popularity": 100.0,
        "vote_count": 200,
        "adult": false,
        "video": false,
      };

      final result = MovieRatedModel.fromJson(mockJson);

      expect(result, isA<MovieRatedModel>());
      expect(result.id, 1);
      expect(result.title, 'Test Movie');
      expect(result.genreIds, []);
    });



  });
}