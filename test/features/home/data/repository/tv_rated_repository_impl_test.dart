

  import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:movie_app/features/home/data/model/tv_rated_model.dart';
import 'package:movie_app/features/home/data/repository/tv_rated_repository_impl.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';


class MockMediaApi extends Mock implements MediaApi {}


void main(){

  group("TvRatedImpl", (){

    late MockMediaApi mockMediaApi;
    late TvRatedRepositoryImpl tvRatedRepositoryImpl;

    setUp((){
      mockMediaApi = MockMediaApi();
      tvRatedRepositoryImpl = TvRatedRepositoryImpl(mediaApi: mockMediaApi);
    });

    // First test to see if getTvRated function returns a list of TvRatedModel
    test("should handle getTvRated function to returns a list of TvRatedModel", () async{
      // Arrange

      final mockResponse = {
        "results": [
          {
            "id": 1,
            "name": "Test TV Show",
            "overview": "This is a test TV show",
            "poster_path": "/test.jpg",
            "vote_average": 8.5,
            "first_air_date": "2023-01-01",
            "backdrop_path": "/backdrop.jpg",
            "original_language": "en",
            "original_name": "Test TV Show Original",
            "media_type": "tv",
            "genre_ids": [1, 2, 3],
            "popularity": 100.0,
            "vote_count": 200,
            "adult": false,
            "origin_country": ["US"],
          }
        ]
      };

      when(() => mockMediaApi.getTvRated(any(), any(), any()))
          .thenAnswer((_) async => HttpResponse(
        mockResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act

      final result = await tvRatedRepositoryImpl.getTvRated();

      // Assert

      expect(result, isA<List<TvRatedModel>>());

      verify(() => mockMediaApi.getTvRated(any(), any(), any())).called(1);

    });

    // Second test to see if getTvRated function throws an exception when error occurs
    test("should handle getTvRated function to throws an exception when error occurs", () {
      // Arrange
      when(() => mockMediaApi.getTvRated(any(), any(), any()))
          .thenThrow(Exception('Failed to fetch TV shows'));


      // Assert
      expect(() => tvRatedRepositoryImpl.getTvRated() , throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getTvRated(any(), any(), any())).called(1);
    });

    // Third test to see if getTvRated function throws an exception when response is not 200
    test("should handle getTvRated function to throws an exception when response is not 200", () {
      // Arrange
      when(() => mockMediaApi.getTvRated(any(), any(), any()))
          .thenAnswer((_) async =>
          HttpResponse(
            {},
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 404,
            ),
          ));
      // Assert

      expect(() => tvRatedRepositoryImpl.getTvRated() , throwsA(isA<Exception>()));
      verify(() => mockMediaApi.getTvRated(any(), any(), any())).called(1);
    });

    // Fourth test to see if getTvDetail function returns a TvRatedModel when given a valid id
    test("should handle getTvDetail to returns a TvRatedModel when given a valid id", () async{
      //arrange
      final mockTvDetailResponse =
        TvRatedModel(
          id: 1,
          name: "Test TV Show",
          overview: "This is a test TV show",
          posterPath: "/test.jpg",
          voteAverage: 8.5,
          firstAirDate: "2023-01-01",
          backdropPath: "/backdrop.jpg",
          originalLanguage: "en",
          originalName: "Test TV Show Original",
          mediaType: "tv",
          genreIds: [1, 2, 3],
          popularity: 100.0,
          voteCount: 200,
          adult: false,
          originCountry: ["US"],
        );

      when(() => mockMediaApi.getTvDetail(any(), any()))
          .thenAnswer((_) async => HttpResponse(
        mockTvDetailResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act

      final result = await tvRatedRepositoryImpl.getTvDetail(1);

      // Assert

      expect(result, isA<TvRatedModel>());
      expect(result.id, 1);
      expect(result.name, "Test TV Show");

      verify(() => mockMediaApi.getTvDetail(any(), any())).called(1);

    });

    // Fifth test to see if getTvDetail function throws an exception when error occurs
    test("should handle getTvDetail function to throws an exception when error occurs", (){
      when(() => mockMediaApi.getTvDetail(any(), any()))
          .thenThrow(Exception('Failed to fetch TV detail'));

      // Assert

      expect(() => tvRatedRepositoryImpl.getTvDetail(1), throwsA(isA<Exception>()));
      verify(() => mockMediaApi.getTvDetail(any(), any())).called(1);

    });

    // Sixth test to see if getTvDetail function throws an exception when response is not 200
    test("should handle getTvDetail function to throws an exception when response is not 200", (){

      final fakeTvRatedModel = TvRatedModel(
        id: 1,
        name: "Test TV Show",
        overview: "This is a test TV show",
        posterPath: "/test.jpg",
        voteAverage: 8.5,
        firstAirDate: "2023-01-01",
        backdropPath: "/backdrop.jpg",
        originalLanguage: "en",
        originalName: "Test TV Show Original",
        mediaType: "tv",
        genreIds: [1, 2, 3],
        popularity: 100.0,
        voteCount: 200,
        adult: false,
        originCountry: ["US"],
      );

      when(() => mockMediaApi.getTvDetail(any(), any()))
          .thenAnswer((_) async =>
          HttpResponse(
            fakeTvRatedModel,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 404,
            ),
          ));

      // Assert

      expect(() => tvRatedRepositoryImpl.getTvDetail(1), throwsA(isA<Exception>()));
      verify(() => mockMediaApi.getTvDetail(any(), any())).called(1);

    });

  });
}