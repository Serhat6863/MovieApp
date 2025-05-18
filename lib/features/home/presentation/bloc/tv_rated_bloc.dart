import 'package:bloc/bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_event.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_state.dart';

import '../../data/repository/tv_rated_repository_impl.dart';

class TvRatedBloc extends Bloc<TvRatedEvent, TvRatedState>{
  final TvRatedRepositoryImpl tvRatedRepositoryImpl;

  TvRatedBloc({required this.tvRatedRepositoryImpl}): super(TvRatedState.initial()){
    on<GetTvRatedEvent>(_getTvRated);
  }


  Future<void> _getTvRated(GetTvRatedEvent event, Emitter<TvRatedState> emit)async {
    emit(TvRatedState.loading());
    try{
      final tvRatedList = await tvRatedRepositoryImpl.getTvRated();
      emit(TvRatedState.success(tvRatedList));
    }catch(e){
      emit(TvRatedState.failure(e.toString()));
    }
  }



}