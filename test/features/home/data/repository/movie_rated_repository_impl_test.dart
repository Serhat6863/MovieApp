import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:movie_app/features/home/data/repository/movie_rated_repository_impl.dart';
import 'package:retrofit/dio.dart';


class MockMediaApi extends Mock implements MediaApi{}


void main(){

  group("MovieRatedImpl", (){

    late MockMediaApi mockMediaApi;
    late MovieRatedRepositoryImpl movieRatedRepositoryImpl;

    setUp((){
      mockMediaApi = MockMediaApi();
      movieRatedRepositoryImpl = MovieRatedRepositoryImpl(mediaApi: mockMediaApi);
    });


    // First test to see if getMovieRated function returns a list of MovieRatedModel
    test("should handle getMovieRated function to returns a list of MovieRatedModel", () async{
      // Arrange

      final mockResponse = {
        "results": [
          {
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
          }
        ]
      };

      when(() => mockMediaApi.getMovieRated(any(), any(), any()))
          .thenAnswer((_) async => HttpResponse(
        mockResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act
      final result = await movieRatedRepositoryImpl.getMovieRated();

      // Assert
      expect(result, isA<List>());
      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].title, "Test Movie");

      verify(() => mockMediaApi.getMovieRated(any(), any(), any())).called(1);
    });

    // Second test to see if getMovieRated function throws an exception when the api call fails
    test("should handle getMovieRated function to throws an exception when error occurs", () {

      when(() => mockMediaApi.getMovieRated(any(), any(), any()))
          .thenThrow(Exception('Failed to fetch movies'));

      // Act & Assert

      expect(() => movieRatedRepositoryImpl.getMovieRated(), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getMovieRated(any(), any(), any())).called(1);
    });

    // Third test to see if getMovieRated function throws an exception when the response is not 200
    test("should handle getMovieRated function to throws an exception when response is not 200", () {

      when(() => mockMediaApi.getMovieRated(any(), any(), any()))
          .thenAnswer((_) async => HttpResponse(
        {},
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      ));

      // Act & Assert

      expect(() => movieRatedRepositoryImpl.getMovieRated(), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getMovieRated(any(), any(), any())).called(1);
    });

    // Fourth test to see if getMovieDetail function returns a MovieRatedModel when given a valid id
    test("should handle getMovieDetail to returns a MovieRatedModel when given a valid id", () async{
      //arrange
      final mockMovieDetailResponse = MovieRatedModel(
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

      when(() => mockMediaApi.getMovieDetail(1, any()))
          .thenAnswer((_) async => HttpResponse(
        mockMovieDetailResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act
      final result = await movieRatedRepositoryImpl.getMovieDetail(1);

      // Assert
      expect(result, isA());
      expect(result.id, 1);
      expect(result.title, "Test Movie");

      verify(() => mockMediaApi.getMovieDetail(1, any())).called(1);
    });

    // Fifth test to see if getMovieDetail function throws an exception when the api call fails
    test("should handle getMovieDetail function to throws an exception when error occurs", () {

      when(() => mockMediaApi.getMovieDetail(1, any()))
          .thenThrow(Exception('Failed to fetch movie detail'));

      // Act & Assert

      expect(() => movieRatedRepositoryImpl.getMovieDetail(1), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getMovieDetail(1, any())).called(1);
    });

    // Sixth test to see if getMovieDetail function throws an exception when the response is not 200
    test("should handle getMovieDetail function to throws an exception when response is not 200", () {

      final fakeMovieRatedModel = MovieRatedModel(
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

      when(() => mockMediaApi.getMovieDetail(1, any()))
          .thenAnswer((_) async => HttpResponse(
        fakeMovieRatedModel,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      ));

      // Act & Assert

      expect(() => movieRatedRepositoryImpl.getMovieDetail(1), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getMovieDetail(1, any())).called(1);
    });

  });





}