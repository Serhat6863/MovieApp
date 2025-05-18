import '../../domain/entities/tv_rated_entitties.dart';

enum TvDetailStatus {
  initial,
  loading,
  success,
  error,}


extension TvDetailStateX on TvDetailStatus {
  bool get isInitial => this == TvDetailStatus.initial;
  bool get isLoading => this == TvDetailStatus.loading;
  bool get isLoaded => this == TvDetailStatus.success;
  bool get isError => this == TvDetailStatus.error;
}


class TvDetailState{
  final TvDetailStatus status;
  final String message;
  final TvEntity ? tvDetail;

  TvDetailState({
    required this.status,
    required this.message,
    this.tvDetail,
  });


  factory TvDetailState.initial() => TvDetailState(
    status: TvDetailStatus.initial,
    message: '',
  );

  factory TvDetailState.loading() => TvDetailState(
    status: TvDetailStatus.loading,
    message: '',
  );

  factory TvDetailState.success(TvEntity tvDetail) => TvDetailState(
    status: TvDetailStatus.success,
    message: '',
    tvDetail: tvDetail,
  );

  factory TvDetailState.error(String message) => TvDetailState(
    status: TvDetailStatus.error,
    message: message,
  );

  TvDetailState copyWith({
    TvDetailStatus? status,
    String? message,
    TvEntity? tvDetail,
  }) {
    return TvDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      tvDetail: tvDetail ?? this.tvDetail,
    );
  }

  @override
  List<Object> get props => [status, message, tvDetail ?? ''];
}