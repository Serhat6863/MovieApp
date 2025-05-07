import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/splash/presentation/bloc/guest_bloc.dart';
import 'package:movie_app/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/splash/data/api/guest_session_api.dart';
import 'features/splash/data/repository/guest_session_repository_impl.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final dio = Dio();
  final guestSessionApi = GuestSessionApi(dio);
  final guestSessionRepository = GuestSessionRepositoryImpl(guestSessionApi , prefs);

  runApp(MyApp(guestSessionRepository: guestSessionRepository , sharedPreferences: prefs));
}

class MyApp extends StatelessWidget {
  final GuestSessionRepositoryImpl guestSessionRepository;
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.guestSessionRepository, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GuestBloc>(
          create: (_) => GuestBloc(guestSessionRepositoryImpl: guestSessionRepository, sharedPreferences: sharedPreferences),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Movie App",
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
