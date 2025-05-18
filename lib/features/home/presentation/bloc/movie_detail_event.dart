import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetMovieRatedEventById extends MovieDetailEvent{
  final int id;

  GetMovieRatedEventById(this.id);

  @override
  List<Object> get props => [id];
}