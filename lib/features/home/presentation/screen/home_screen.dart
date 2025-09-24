import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/person_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/person_event.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_state.dart';
import 'package:movie_app/features/home/presentation/screen/detail_screen.dart';
import 'package:movie_app/features/home/presentation/widget/custom_list_view.dart';

import '../../../../core/constant.dart';
import '../bloc/movie_rated_bloc.dart';
import '../bloc/movie_rated_event.dart';
import '../bloc/movie_rated_state.dart';
import '../bloc/person_state.dart';
import '../bloc/tv_rated_event.dart';
import 'home_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieRatedBloc>().add(GetMovieRatedEvent());
      context.read<TvRatedBloc>().add(GetTvRatedEvent());
      context.read<PersonBloc>().add(GetPersonEvent());
    });
  }

  Future<void> _onRefresh() async {
    context.read<MovieRatedBloc>().add(GetMovieRatedEvent());
    context.read<TvRatedBloc>().add(GetTvRatedEvent());
    context.read<PersonBloc>().add(GetPersonEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12.0),
            children: [
              Row(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionHeader("Top Rated Movies"),
              BlocBuilder<MovieRatedBloc, MovieRatedState>(
                buildWhen: (previous, current) =>
                current.status != previous.status ||
                    current.movieRatedList != previous.movieRatedList ||
                    current.message != previous.message,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status.isFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state.status.isSuccess) {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movieRatedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.movieRatedList[index].id,
                                      mediaType: "movie",
                                    ),
                                  ),
                                );
                              },
                              child: CustomListView(
                                imageUrl:
                                "https://image.tmdb.org/t/p/w500${state.movieRatedList[index].posterPath}",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text("No Data", style: TextStyle(color: Colors.red)),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildSectionHeader("Top Rated TV Shows"),
              BlocBuilder<TvRatedBloc, TvRatedState>(
                buildWhen: (previous, current) =>
                current.status != previous.status ||
                    current.tvRatedList != previous.tvRatedList ||
                    current.message != previous.message,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status.isFailure) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (state.status.isSuccess) {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.tvRatedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.tvRatedList[index].id,
                                      mediaType: "tv",
                                    ),
                                  ),
                                );
                              },
                              child: CustomListView(
                                imageUrl:
                                "https://image.tmdb.org/t/p/w500${state.tvRatedList[index].posterPath}",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text("No Data", style: TextStyle(color: Colors.red)),
                  );
                },
              ),

              const SizedBox(height: 20),

              _buildSectionHeader("Popular Persons"),

              const SizedBox(height: 10),

              BlocBuilder<PersonBloc, PersonState>(
                buildWhen: (previous, current) =>
                current.status != previous.status ||
                    current.personList != previous.personList ||
                    current.message != previous.message,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status.isError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (state.status.isLoaded) {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.personList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500${state.personList[index].profilePath}",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    state.personList[index].name,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text("No Data", style: TextStyle(color: Colors.red)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          "See All",
          style: TextStyle(
            color: kTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
