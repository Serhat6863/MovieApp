
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/model/tv_rated_model.dart';
import 'package:movie_app/features/home/data/repository/tv_rated_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_event.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_state.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_event.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_state.dart';

class MockTvRatedRepositoryImpl extends Mock implements TvRatedRepositoryImpl {}

void main(){

  group("TvRatedBloc", (){

    final mockTvRatedRepositoryImpl = MockTvRatedRepositoryImpl();

    final mockTv = [
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
      )
    ];

    blocTest<TvRatedBloc, TvRatedState>(
      "handles successful data fetching",
      build: () => TvRatedBloc(tvRatedRepositoryImpl: mockTvRatedRepositoryImpl),
      setUp: (){
        when(() => mockTvRatedRepositoryImpl.getTvRated())
            .thenAnswer((_) async => mockTv);
      },
      act: (bloc) => bloc.add(GetTvRatedEvent()),
      expect: () => [
        TvRatedState.loading(),
        TvRatedState.success(mockTv),
      ]
    );


    blocTest<TvRatedBloc, TvRatedState>(
      "handles error during data fetching",
      build: () => TvRatedBloc(tvRatedRepositoryImpl: mockTvRatedRepositoryImpl),
      setUp: (){
        when(() => mockTvRatedRepositoryImpl.getTvRated())
            .thenThrow(Exception('Failed to fetch TV shows'));
      },
      act: (bloc) => bloc.add(GetTvRatedEvent()),
      expect: () => [
        TvRatedState.loading(),
        TvRatedState.failure('Exception: Failed to fetch TV shows'),
      ]
    );

  });

  group("TvDetailBloc", (){


    final mockTvRatedRepositoryImpl = MockTvRatedRepositoryImpl();

    final mockTvDetail = TvRatedModel(
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


    blocTest<TvDetailBloc, TvDetailState>(
      "handles successful data fetching",
      build: () => TvDetailBloc(tvRatedRepositoryImpl: mockTvRatedRepositoryImpl),
      setUp: (){
        when(() => mockTvRatedRepositoryImpl.getTvDetail(1))
            .thenAnswer((_) async => mockTvDetail);
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(1)),
      expect: () => [
        TvDetailState.loading(),
        TvDetailState.success(mockTvDetail),
      ]
    );


    blocTest<TvDetailBloc, TvDetailState>(
      "handles error during data fetching",
      build: () => TvDetailBloc(tvRatedRepositoryImpl: mockTvRatedRepositoryImpl),
      setUp: (){
        when(() => mockTvRatedRepositoryImpl.getTvDetail(1))
            .thenThrow(Exception('Failed to fetch TV detail'));
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(1)),
      expect: () => [
        TvDetailState.loading(),
        TvDetailState.error('Exception: Failed to fetch TV detail'),
      ]
    );

  });

}