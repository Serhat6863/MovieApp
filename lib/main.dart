import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:movie_app/features/home/data/repository/tv_rated_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_bloc.dart';
import 'package:movie_app/features/splash/presentation/bloc/guest_bloc.dart';
import 'package:movie_app/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/data/repository/movie_rated_repository_impl.dart';
import 'features/home/presentation/bloc/tv_rated_bloc.dart';
import 'features/splash/data/api/guest_session_api.dart';
import 'features/splash/data/repository/guest_session_repository_impl.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final dio = Dio();
  final guestSessionApi = GuestSessionApi(dio);
  final guestSessionRepository = GuestSessionRepositoryImpl(guestSessionApi , prefs);

  final mediaApi = MediaApi(dio);
  final movieRatedRepository = MovieRatedRepositoryImpl(mediaApi: mediaApi);

  final tvRatedRepository = TvRatedRepositoryImpl(mediaApi: mediaApi);

  runApp(MyApp(guestSessionRepository: guestSessionRepository , sharedPreferences: prefs, movieRatedRepository: movieRatedRepository, tvRatedRepository: tvRatedRepository,));
}

class MyApp extends StatelessWidget {
  final GuestSessionRepositoryImpl guestSessionRepository;
  final MovieRatedRepositoryImpl movieRatedRepository;
  final TvRatedRepositoryImpl tvRatedRepository;
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.guestSessionRepository, required this.sharedPreferences, required this.movieRatedRepository, required this.tvRatedRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GuestBloc>(
          create: (_) => GuestBloc(guestSessionRepositoryImpl: guestSessionRepository, sharedPreferences: sharedPreferences),
        ),
        BlocProvider<MovieRatedBloc>(
          create: (_) => MovieRatedBloc(movieRatedRepositoryImpl: movieRatedRepository),
        ),
        BlocProvider<TvRatedBloc>(
          create: (_) => TvRatedBloc(tvRatedRepositoryImpl: tvRatedRepository),
        )

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
