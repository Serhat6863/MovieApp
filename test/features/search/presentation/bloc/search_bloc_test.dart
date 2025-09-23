

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/search/data/model/search_result_model.dart';
import 'package:movie_app/features/search/data/repository/search_result_repository_impl.dart';
import 'package:movie_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:movie_app/features/search/presentation/bloc/search_event.dart';
import 'package:movie_app/features/search/presentation/bloc/search_state.dart';

class MockSearchRepositoryImpl  extends Mock implements SearchResultRepositoryImpl {}


void main(){

  group("SearchBloc", (){

    final mockSearchRepositoryImpl = MockSearchRepositoryImpl();

    final mockSearchResults = [
      SearchResultModel(
        id: 1,
        mediaType: "movie",
        title: "Test Movie",
        posterPath: "/test.jpg",
        backdropPath: "/backdrop.jpg",
      ),
    ];

    blocTest<SearchBloc, SearchState>(
      "handles successful and emits loading and success states",
      build: () => SearchBloc(searchResultRepositoryImpl: mockSearchRepositoryImpl),
      setUp: (){
        when(() => mockSearchRepositoryImpl.searchMultiple(any()))
            .thenAnswer((_) async => mockSearchResults);
      },
      act: (bloc) => bloc.add(GetSearchMovieEvent("Test")),
      expect: () => [
        SearchState.loading(),
        SearchState.success(mockSearchResults),
      ],

      verify: (_) {
        verify(() => mockSearchRepositoryImpl.searchMultiple("Test")).called(1);
      },
    );


    blocTest<SearchBloc, SearchState>(
      "handles failure and emits loading and failure states",
      build: () => SearchBloc(searchResultRepositoryImpl: mockSearchRepositoryImpl),
      setUp: (){
        when(() => mockSearchRepositoryImpl.searchMultiple(any()))
            .thenThrow(Exception("Failed to fetch search results"));
      },
      act: (bloc) => bloc.add(GetSearchMovieEvent("Test")),
      expect: () => [
        SearchState.loading(),
        SearchState.failure("Exception: Failed to fetch search results"),
      ],

      verify: (_) {
        verify(() => mockSearchRepositoryImpl.searchMultiple("Test")).called(1);
      },
    );


  });

}