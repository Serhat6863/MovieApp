import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/home/data/model/movie_rated_model.dart';
import 'package:movie_app/features/home/data/repository/movie_rated_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_detail_event.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_detail_state.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_event.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_state.dart';


class MockMovieRepositoryImpl extends Mock implements MovieRatedRepositoryImpl{}

void main(){
  group("MovieRatedBloc", (){

    final mockMovieRepositoryImpl = MockMovieRepositoryImpl();

    final mockMovie = [
      MovieRatedModel(
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
      )
    ];


    blocTest<MovieRatedBloc, MovieRatedState>(
        'handles successful data fetching',
        build: () => MovieRatedBloc(movieRatedRepositoryImpl: mockMovieRepositoryImpl),
        setUp: (){
          when(() => mockMovieRepositoryImpl.getMovieRated())
              .thenAnswer((_) async => mockMovie);
        },
        act: (bloc) => bloc.add(GetMovieRatedEvent()),
        expect: () => [
          MovieRatedState.loading(),
          MovieRatedState.success(mockMovie),
        ]
    );


    blocTest<MovieRatedBloc, MovieRatedState>(
        'handles error during data fetching',
        build: () => MovieRatedBloc(movieRatedRepositoryImpl: mockMovieRepositoryImpl),
        setUp: (){
          when(() => mockMovieRepositoryImpl.getMovieRated())
              .thenThrow(Exception("Failed to fetch movie"));
        },
        act: (bloc) => bloc.add(GetMovieRatedEvent()),
        expect: () => [
          MovieRatedState.loading(),
          MovieRatedState.failure('Exception: Failed to fetch movie'),
        ]
    );

  });


  group("MovieDetailBloc", (){

    final mockMovieRepositoryImpl = MockMovieRepositoryImpl();

    final mockMovieDetail = MovieRatedModel(
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


    blocTest<MovieDetailBloc, MovieDetailState>(
      'handles successful data fetching by id',
      build: () => MovieDetailBloc(movieRatedRepositoryImpl: mockMovieRepositoryImpl),
      setUp: (){
        when(() => mockMovieRepositoryImpl.getMovieDetail(1))
            .thenAnswer((_) async => mockMovieDetail);
      },
      act: (bloc) => bloc.add(GetMovieRatedEventById(1)),
      expect: () => [
        MovieDetailState.loading(),
        MovieDetailState.success(mockMovieDetail),
      ]
    );


    blocTest<MovieDetailBloc, MovieDetailState>(
        'handles error during data fetching by id',
        build: () => MovieDetailBloc(movieRatedRepositoryImpl: mockMovieRepositoryImpl),
        setUp: (){
          when(() => mockMovieRepositoryImpl.getMovieDetail(1))
              .thenThrow(Exception("Failed to fetch movie detail"));
        },
        act: (bloc) => bloc.add(GetMovieRatedEventById(1)),
        expect: () => [
          MovieDetailState.loading(),
          MovieDetailState.failure('Exception: Failed to fetch movie detail'),
        ]
    );


  });
}