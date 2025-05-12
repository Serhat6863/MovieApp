import 'package:equatable/equatable.dart';

abstract class MovieRatedEvent extends Equatable{

  @override
  List<Object> get props => [];
}


class GetMovieRatedEvent extends MovieRatedEvent{

  @override
  List<Object> get props => [];
}


class GetMovieRatedEventById extends MovieRatedEvent{
  final int id;

  GetMovieRatedEventById(this.id);

  @override
  List<Object> get props => [id];
}