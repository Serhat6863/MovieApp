import 'package:movie_app/features/splash/domain/entities/guest_session_entities.dart';

enum GuestStatus { initial, loading, loaded, error }

extension GuestStateX on GuestStatus {
  bool get isInitial => this == GuestStatus.initial;
  bool get isLoading => this == GuestStatus.loading;
  bool get isLoaded => this == GuestStatus.loaded;
  bool get isError => this == GuestStatus.error;
}

class GuestState {
  final GuestStatus status;
  final String message;
  final GuestSessionEntity? guestSessionId;

  GuestState({
    required this.status,
    required this.message,
    this.guestSessionId,
  });

  factory GuestState.initial() =>
      GuestState(status: GuestStatus.initial, message: '');

  factory GuestState.loading() =>
      GuestState(status: GuestStatus.loading, message: '');

  factory GuestState.loaded(GuestSessionEntity guestSessionId) => GuestState(
    status: GuestStatus.loaded,
    message: '',
    guestSessionId: guestSessionId,
  );

  factory GuestState.error(String message) =>
      GuestState(status: GuestStatus.error, message: message);

  GuestState copyWith({GuestStatus? status, String? message}) {
    return GuestState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
