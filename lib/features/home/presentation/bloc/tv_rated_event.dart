import 'package:equatable/equatable.dart';

abstract class TvRatedEvent extends Equatable{

  @override
  List<Object> get props => [];


}


class GetTvRatedEvent extends TvRatedEvent{

  @override
  List<Object> get props => [];
}


class GetTvRatedEventById extends TvRatedEvent{
  final int id;

  GetTvRatedEventById(this.id);

  @override
  List<Object> get props => [id];
}