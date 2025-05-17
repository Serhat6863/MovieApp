import '../../domain/entities/tv_rated_entitties.dart';

enum TvRatedStatus { initial, loading, success, failure , detail }

extension TvRatedStateX on TvRatedStatus{
  bool get isInitial => this == TvRatedStatus.initial;
  bool get isLoading => this == TvRatedStatus.loading;
  bool get isSuccess => this == TvRatedStatus.success;
  bool get isFailure => this == TvRatedStatus.failure;
  bool get isDetail => this == TvRatedStatus.detail;
}


class TvRatedState{
  final TvRatedStatus status;
  final String message;
  final List<TvEntity> tvRatedList;
  final TvEntity? tvRated;

  TvRatedState({
    required this.status,
    required this.message,
    required this.tvRatedList,
    this.tvRated,
  });

  factory TvRatedState.initial() => TvRatedState(
    status: TvRatedStatus.initial,
    message: '',
    tvRatedList: [],
  );

  factory TvRatedState.loading() => TvRatedState(
    status: TvRatedStatus.loading,
    message: '',
    tvRatedList: [],
  );

  factory TvRatedState.success(List<TvEntity> tvRatedList) => TvRatedState(
    status: TvRatedStatus.success,
    message: '',
    tvRatedList: tvRatedList,
  );

  factory TvRatedState.failure(String message) => TvRatedState(
    status: TvRatedStatus.failure,
    message: message,
    tvRatedList: [],
  );

  factory TvRatedState.detail(TvEntity tvRated) => TvRatedState(
    status: TvRatedStatus.detail,
    message: '',
    tvRatedList: [],
    tvRated: tvRated,
  );


  TvRatedState copyWith({
    TvRatedStatus? status,
    String? message,
    List<TvEntity>? tvRatedList,
    TvEntity? tvRated,
  }) {
    return TvRatedState(
      status: status ?? this.status,
      message: message ?? this.message,
      tvRatedList: tvRatedList ?? this.tvRatedList,
      tvRated: tvRated ?? this.tvRated,
    );
  }

  @override
  List<Object> get props => [status, message, tvRatedList , tvRated ?? ''];

}