import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/model/person_model.dart';
import 'package:movie_app/features/home/data/repository/person_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/person_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/person_event.dart';
import 'package:movie_app/features/home/presentation/bloc/person_state.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPersonRepositoryImpl extends Mock implements PersonRepositoryImpl {}

void main(){
  group('PersonBloc', (){

    final mockPersonRepositoryImpl = MockPersonRepositoryImpl();

    final mockPersons = [
      PersonModel(
        name: "Serhat",
        profilePath: "/path/to/profile.jpg",
        id: 1,
        popularity: 10.0,
        adult: false,
        mediaType: "person",
        gender: 1,
        originalName: 'Serhat',
        knownForDepartment: "Acting",
      ),
    ];


    blocTest<PersonBloc, PersonState>(
      'handles GetPersonEvent and emits loading and success states',
      build: () => PersonBloc(personRepositoryImpl: mockPersonRepositoryImpl),
      setUp: (){
        when(() => mockPersonRepositoryImpl.getPerson())
            .thenAnswer((_) async => mockPersons);
      },
      act: (bloc) => bloc.add(GetPersonEvent()),
      expect: () => [
        PersonState.loading(),
        PersonState.success(mockPersons),
      ],
    );


    blocTest<PersonBloc, PersonState>(
      'handles GetPersonEvent and emits loading and success states when error',
      build: () => PersonBloc(personRepositoryImpl: mockPersonRepositoryImpl),
      setUp: (){
        when(() => mockPersonRepositoryImpl.getPerson())
            .thenThrow(Exception('Failed to fetch persons'));
      },
      act: (bloc) => bloc.add(GetPersonEvent()),
      expect: () => [
        PersonState.loading(),
        PersonState.failure('Exception: Failed to fetch persons'),
      ],
    );

  });
}