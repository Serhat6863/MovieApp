class GuestSessionEntity {
  final String guestSessionId;
  final DateTime expiresAt;

  const GuestSessionEntity({
    required this.guestSessionId,
    required this.expiresAt,
  });
}