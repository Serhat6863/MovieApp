import '../../domain/entities/movie_rated_entities.dart';

enum MovieRatedStatus { initial, loading, success, failure, detail }

extension MovieRatedStateX on MovieRatedStatus {
  bool get isInitial => this == MovieRatedStatus.initial;
  bool get isLoading => this == MovieRatedStatus.loading;
  bool get isSuccess => this == MovieRatedStatus.success;
  bool get isFailure => this == MovieRatedStatus.failure;
  bool get isDetail => this == MovieRatedStatus.detail;
}

class MovieRatedState {
  final MovieRatedStatus status;
  final String message;
  final List<MovieEntity> movieRatedList;
  final MovieEntity? movieRatedDetail;

  MovieRatedState({
    required this.status,
    required this.message,
    required this.movieRatedList,
    this.movieRatedDetail,
  });

  factory MovieRatedState.initial() => MovieRatedState(
    status: MovieRatedStatus.initial,
    message: '',
    movieRatedList: [],
  );

  factory MovieRatedState.loading() => MovieRatedState(
    status: MovieRatedStatus.loading,
    message: '',
    movieRatedList: [],
  );

  factory MovieRatedState.success(List<MovieEntity> movieRatedList) => MovieRatedState(
    status: MovieRatedStatus.success,
    message: '',
    movieRatedList: movieRatedList,
  );

  factory MovieRatedState.failure(String message) => MovieRatedState(
    status: MovieRatedStatus.failure,
    message: message,
    movieRatedList: [],
  );

  factory MovieRatedState.detail(MovieEntity movieRatedDetail) => MovieRatedState(
    status: MovieRatedStatus.detail,
    message: '',
    movieRatedList: [],
    movieRatedDetail: movieRatedDetail,
  );


  MovieRatedState copyWith({
    MovieRatedStatus? status,
    String? message,
    List<MovieEntity>? movieRatedList,
    MovieEntity? movieRatedDetail,
  }) {
    return MovieRatedState(
      status: status ?? this.status,
      message: message ?? this.message,
      movieRatedList: movieRatedList ?? this.movieRatedList,
      movieRatedDetail: movieRatedDetail ?? this.movieRatedDetail,
    );
  }

  @override
  List<Object> get props => [status, message, movieRatedList, movieRatedDetail ?? ''];
}
