import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/search/data/api/search_result_api.dart';
import 'package:movie_app/features/search/data/repository/search_result_repository_impl.dart';
import 'package:retrofit/dio.dart';


class MockSearchResultApi extends Mock implements SearchResultApi{}

void main(){

  group("SearchResulRepositoryImpl", (){

    late MockSearchResultApi mockSearchResultApi;
    late SearchResultRepositoryImpl searchResultRepositoryImpl;

    setUp((){
      mockSearchResultApi = MockSearchResultApi();
      searchResultRepositoryImpl = SearchResultRepositoryImpl(searchResultApi: mockSearchResultApi);
    });


    // First test to see if searchMultiple function returns a list of SearchResultModel
    test("should handle searchMultiple function to returns a list of SearchResultModel ", () async{

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

      // Arrange

      when(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any()))
      .thenAnswer((_) async => HttpResponse(
        mockResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act
      final result = await searchResultRepositoryImpl.searchMultiple("query");

      // Assert
      expect(result, isA<List>());
      expect(result.length, 1);
      expect(result[0].id, 1);

      verify(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any())).called(1);

    });


    // Second test to see if searchMultiple function throws an exception when the api call fails
    test("should throw an exception when the api call fails", () async{

      // Arrange
      when(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any()))
      .thenThrow(Exception("Failed to fetch search results"));

      // Act
      final call = searchResultRepositoryImpl.searchMultiple;

      // Assert
      expect(() => call("query"), throwsA(isA<Exception>()));

      verify(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any())).called(1);

    });

    // Third test to see if searchMultiple function throws an exception when the response is not 200
    test("should throw an exception when the response is not 200", () async{

      // Arrange
      when(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any()))
      .thenAnswer((_) async => HttpResponse(
        {},
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
      ));

      // Act
      final call = searchResultRepositoryImpl.searchMultiple;

      // Assert
      expect(() => call("query"), throwsA(isA<Exception>()));

      verify(() => mockSearchResultApi.getSearchResult(any(), any(), any(), any(), any())).called(1);

    });

  });
}