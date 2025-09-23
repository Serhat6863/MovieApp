import 'package:bloc/bloc.dart';
import 'package:movie_app/features/search/data/repository/search_result_repository_impl.dart';
import 'package:movie_app/features/search/presentation/bloc/search_event.dart';
import 'package:movie_app/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchResultRepositoryImpl searchResultRepositoryImpl;


  SearchBloc({required this.searchResultRepositoryImpl}) : super(SearchState.initial()) {
    on<GetSearchMovieEvent>(_onSearch);
  }



  Future<void> _onSearch(GetSearchMovieEvent event, Emitter<SearchState> emit) async {
    emit(SearchState.loading());
    try{
      final searchResults = await searchResultRepositoryImpl.searchMultiple(event.query);
      emit(SearchState.success(searchResults));
    } catch (e) {
      emit(SearchState.failure(e.toString()));
    }
  }
}