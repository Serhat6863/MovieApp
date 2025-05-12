import 'package:bloc/bloc.dart';

import '../../data/repository/movie_rated_repository_impl.dart';
import 'movie_rated_event.dart';
import 'movie_rated_state.dart';

class MovieRatedBloc extends Bloc<MovieRatedEvent, MovieRatedState>{

  final MovieRatedRepositoryImpl movieRatedRepositoryImpl;

  MovieRatedBloc({required this.movieRatedRepositoryImpl}): super(MovieRatedState.initial()){
    on<GetMovieRatedEvent>(_getMovieRated);
    on<GetMovieRatedEventById>(_getMovieRatedById);
  }


  Future<void> _getMovieRated(GetMovieRatedEvent event, Emitter<MovieRatedState> emit) async{
    emit(MovieRatedState.loading());
    try{
      final movieRatedList = await movieRatedRepositoryImpl.getMovieRated();
      emit(MovieRatedState.success(movieRatedList));
    }catch(e){
      emit(MovieRatedState.failure(e.toString()));
    }
  }

  Future<void> _getMovieRatedById(GetMovieRatedEventById event, Emitter<MovieRatedState> emit) async{
    emit(MovieRatedState.loading());
    try{
      print("fetching movie rated by id : ${event.id}");
      final movieRated = await movieRatedRepositoryImpl.getMovieDetail(event.id);
      print("movie fetched : ${movieRated.title}");
      emit(MovieRatedState.detail(movieRated));
    }catch(e){
      emit(MovieRatedState.failure(e.toString()));
    }
  }



}