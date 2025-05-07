import 'package:movie_app/core/constant.dart';
import 'package:movie_app/features/splash/data/api/guest_session_api.dart';
import 'package:movie_app/features/splash/data/model/guest_session_model.dart';
import 'package:movie_app/features/splash/domain/entities/guest_session_entities.dart';
import 'package:movie_app/features/splash/domain/repository/guest_session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestSessionRepositoryImpl implements GuestSessionRepository {
  final GuestSessionApi guestSessionApi;
  final SharedPreferences sharedPreferences;

  GuestSessionRepositoryImpl(this.guestSessionApi, this.sharedPreferences);

  @override
  Future<GuestSessionEntity> createGuestSession() async {
    try {
      final response = await guestSessionApi.getGuestSession("Bearer $kApiKey");

      if (response.response.statusCode != 200) {
        throw Exception('Failed to create guest session');
      }

      return GuestSessionModel.fromJson(response.response.data);

    } catch (e) {
      throw Exception('Failed to create guest session: $e');
    }
  }


}
