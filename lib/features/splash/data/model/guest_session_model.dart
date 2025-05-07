import 'package:movie_app/features/splash/domain/entities/guest_session_entities.dart';

class GuestSessionModel extends GuestSessionEntity{
  const GuestSessionModel({
    required super.guestSessionId,
    required super.expiresAt,
  });

  factory GuestSessionModel.fromJson(Map<String, dynamic> json) {
    return GuestSessionModel(
      guestSessionId: json['guest_session_id'],
      expiresAt: DateTime.parse(json['expires_at'].replaceFirst(" UTC", "Z")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guest_session_id': guestSessionId,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}