import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/person_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_detail_bloc.dart';
import 'package:movie_app/features/home/data/repository/movie_rated_repository_impl.dart';
import 'package:movie_app/features/home/data/repository/tv_rated_repository_impl.dart';
import 'package:movie_app/features/home/data/repository/person_repository_impl.dart';
import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/search/presentation/bloc/search_bloc.dart';

import 'features/home/presentation/screen/home_navigation.dart';
import 'features/search/data/api/search_result_api.dart';
import 'features/search/data/repository/search_result_repository_impl.dart';

void main() {
  final dio = Dio();
  //api movie
  final mediaApi = MediaApi(dio);

  //api search
  final searchResultApi = SearchResultApi(dio);

  final movieRepo = MovieRatedRepositoryImpl(mediaApi: mediaApi);
  final tvRepo = TvRatedRepositoryImpl(mediaApi: mediaApi);
  final personRepo = PersonRepositoryImpl(mediaApi: mediaApi);
  final searchRepo = SearchResultRepositoryImpl(searchResultApi: searchResultApi);

  runApp(MyApp(
    movieRepo: movieRepo,
    tvRepo: tvRepo,
    personRepo: personRepo,
    searchRepo: searchRepo,
  ));
}

class MyApp extends StatelessWidget {
  final MovieRatedRepositoryImpl movieRepo;
  final TvRatedRepositoryImpl tvRepo;
  final PersonRepositoryImpl personRepo;
  final SearchResultRepositoryImpl searchRepo;

  const MyApp({
    super.key,
    required this.movieRepo,
    required this.tvRepo,
    required this.personRepo,
    required this.searchRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieRatedBloc(movieRatedRepositoryImpl: movieRepo)),
        BlocProvider(create: (_) => TvRatedBloc(tvRatedRepositoryImpl: tvRepo)),
        BlocProvider(create: (_) => PersonBloc(personRepositoryImpl: personRepo)),
        BlocProvider(create: (_) => MovieDetailBloc(movieRatedRepositoryImpl: movieRepo)),
        BlocProvider(create: (_) => TvDetailBloc(tvRatedRepositoryImpl: tvRepo)),
        BlocProvider(create: (_) => SearchBloc(searchResultRepositoryImpl: searchRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark(),
        home: const HomeNavigation(),
      ),
    );
  }
}
