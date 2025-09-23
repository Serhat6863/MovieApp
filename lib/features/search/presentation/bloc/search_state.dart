import 'package:equatable/equatable.dart';
import 'package:movie_app/features/search/domain/entity/search_result_entity.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  failure,
}


extension SearchStatusExtension on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
}


class SearchState extends Equatable{
  final SearchStatus status;
  final String message;
  final List<SearchResultEntity> ? searchResults;


  const SearchState({
    required this.status,
    required this.message,
    this.searchResults,
  });



  factory SearchState.initial() => SearchState(
    status: SearchStatus.initial,
    message: '',
  );

  factory SearchState.loading() => SearchState(
    status: SearchStatus.loading,
    message: '',
  );


  factory SearchState.success(List<SearchResultEntity> searchResults) => SearchState(
    status: SearchStatus.success,
    message: '',
    searchResults: searchResults,
  );

  factory SearchState.failure(String message) => SearchState(
    status: SearchStatus.failure,
    message: message,
  );


  SearchState copyWith({
    SearchStatus? status,
    String? message,
    List<dynamic>? searchResults,
  }) {
    return SearchState(
      status: status ?? this.status,
      message: message ?? this.message,
      searchResults: searchResults as List<SearchResultEntity>?,
    );
  }

  @override
  List<Object> get props => [status, message, searchResults ?? []];
}