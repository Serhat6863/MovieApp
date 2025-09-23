import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetSearchMovieEvent extends SearchEvent{
  final String query;

  GetSearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}