import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable{
  @override
  List<Object> get props => [];
}


class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  GetTvDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}