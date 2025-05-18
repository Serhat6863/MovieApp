import 'package:bloc/bloc.dart';
import 'package:movie_app/features/home/data/repository/movie_rated_repository_impl.dart';

import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRatedRepositoryImpl movieRatedRepositoryImpl;

  MovieDetailBloc({required this.movieRatedRepositoryImpl}) : super(MovieDetailState.initial()) {
    on<GetMovieRatedEventById>(_getMovieDetail);
  }


  Future<void> _getMovieDetail(GetMovieRatedEventById event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailState.loading());
    try {
      final movieRated = await movieRatedRepositoryImpl.getMovieDetail(event.id);
      emit(MovieDetailState.success(movieRated));
    } catch (e) {
      emit(MovieDetailState.failure(e.toString()));
    }
  }
}