import 'package:movie_app/features/splash/domain/entities/guest_session_entities.dart';

abstract class GuestSessionRepository {
  Future<GuestSessionEntity> createGuestSession();

}