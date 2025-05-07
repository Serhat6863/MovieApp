import 'package:dio/dio.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/features/splash/data/model/guest_session_model.dart';
import 'package:retrofit/retrofit.dart';

part 'guest_session_api.g.dart';


@RestApi(baseUrl: baseUrl)
abstract class GuestSessionApi{
  factory GuestSessionApi(Dio dio) = _GuestSessionApi;

  @GET("/authentication/guest_session/new")
  Future<HttpResponse<GuestSessionModel>> getGuestSession(
      @Header("Authorization") String apiKey,
      );

}