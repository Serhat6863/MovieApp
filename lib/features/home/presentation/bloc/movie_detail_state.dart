import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_rated_entities.dart';

enum MovieDetailStatus {
  initial,
  loading,
  success,
  failure,
}

extension MovieDetailStateX on MovieDetailStatus {
  bool get isInitial => this == MovieDetailStatus.initial;
  bool get isLoading => this == MovieDetailStatus.loading;
  bool get isLoaded => this == MovieDetailStatus.success;
  bool get isError => this == MovieDetailStatus.failure;
}



class MovieDetailState extends Equatable{
  final MovieDetailStatus status;
  final String message;
  final MovieEntity ? movieDetail;

  const MovieDetailState({
    required this.status,
    required this.message,
    this.movieDetail,
  });



  factory MovieDetailState.initial() => MovieDetailState(
    status: MovieDetailStatus.initial,
    message: '',
  );

  factory MovieDetailState.loading() => MovieDetailState(
    status: MovieDetailStatus.loading,
    message: '',
  );

  factory MovieDetailState.success(MovieEntity movieDetail) => MovieDetailState(
    status: MovieDetailStatus.success,
    message: '',
    movieDetail: movieDetail,
  );

  factory MovieDetailState.failure(String message) => MovieDetailState(
    status: MovieDetailStatus.failure,
    message: message,
  );

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    String? message,
    MovieEntity? movieDetail,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      movieDetail: movieDetail ?? this.movieDetail,
    );
  }

  @override
  List<Object> get props => [status, message, movieDetail ?? ''];
}