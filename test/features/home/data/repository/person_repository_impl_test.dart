import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:movie_app/features/home/data/model/person_model.dart';
import 'package:movie_app/features/home/data/repository/person_repository_impl.dart';
import 'package:retrofit/dio.dart';

class MockMediaApi extends Mock implements MediaApi{}

void main(){
  group("personRepositoryImpl", (){

    late MockMediaApi mockMediaApi;
    late PersonRepositoryImpl personRepositoryImpl;

    setUp((){
      mockMediaApi = MockMediaApi();
      personRepositoryImpl = PersonRepositoryImpl(mediaApi: mockMediaApi);
    });


    // First test to see if getPerson function returns a list of PersonModel
    test("should handle getPerson function to returns a list of PersonModel", () async{

      final mockResponse = {
        "results": [
          {
            "id" : 1,
            "name": "Serhat",
            "profile_path": "/path/to/profile.jpg",
            "popularity": 10.0,
            "adult": false,
            "media_type" : "person",
            "gender" : 1,
            "original_name" : "Serhat",
            "known_for_department" : "Acting"
          }
        ]
      };

      // Arrange

      when(() => mockMediaApi.getPerson(any(), any(), any()))
      .thenAnswer((_) async => HttpResponse(
        mockResponse,
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      ));

      // Act
      final result = await personRepositoryImpl.getPerson();

      // Assert
      expect(result, isA<List<PersonModel>>());
      expect(result.length, 1);
      expect(result.first.name, 'Serhat');

      verify(() => mockMediaApi.getPerson(any(), any(), any())).called(1);

    });

    // Second test to see if getPerson function throws an exception when the api call fails
    test("should throw an exception when the api call fails", () async{

      // Arrange
      when(() => mockMediaApi.getPerson(any(), any(), any()))
      .thenThrow(Exception('Failed to fetch persons'));

      // Act
      final call = personRepositoryImpl.getPerson;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getPerson(any(), any(), any())).called(1);

    });

    // Third test to see if getPerson function throws an exception when the response is not 200
    test("should throw an exception when the response is not 200", () async{


      // Arrange
      when(() => mockMediaApi.getPerson(any(), any(), any()))
          .thenAnswer((_) async =>
          HttpResponse(
            {},
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 404,
            ),
          ));

      // Act
      final call = personRepositoryImpl.getPerson;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));

      verify(() => mockMediaApi.getPerson(any(), any(), any())).called(1);
    });
  });
}