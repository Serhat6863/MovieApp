import 'package:bloc/bloc.dart';
import 'package:movie_app/features/home/data/repository/tv_rated_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_event.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final TvRatedRepositoryImpl tvRatedRepositoryImpl;

  TvDetailBloc({required this.tvRatedRepositoryImpl}) : super(TvDetailState.initial()) {
    on<GetTvDetailEvent>(_getTvDetail);
  }


  Future<void> _getTvDetail(GetTvDetailEvent event, Emitter<TvDetailState> emit) async {
    emit(TvDetailState.loading());
    try {
      final tvDetail = await tvRatedRepositoryImpl.getTvDetail(event.id);
      emit(TvDetailState.success(tvDetail));
    } catch (e) {
      emit(TvDetailState.error(e.toString()));
    }
  }
}