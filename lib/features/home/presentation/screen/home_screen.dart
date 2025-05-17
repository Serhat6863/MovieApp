import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_state.dart';
import 'package:movie_app/features/home/presentation/screen/detail_screen.dart';
import 'package:movie_app/features/home/presentation/widget/custom_list_view.dart';
import 'package:movie_app/features/home/presentation/widget/section_header_row.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constant.dart';
import '../bloc/movie_rated_bloc.dart';
import '../bloc/movie_rated_event.dart';
import '../bloc/movie_rated_state.dart';
import '../bloc/person_bloc.dart';
import '../bloc/person_event.dart';
import '../bloc/person_state.dart';
import '../bloc/tv_rated_event.dart';
import '../widget/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TestScreen(),
    TestScreenSecond(),
    TalScreen(),
    TolScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieRatedBloc>().add(GetMovieRatedEvent());
    context.read<TvRatedBloc>().add(GetTvRatedEvent());
    context.read<PersonBloc>().add(GetPersonEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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

                  Spacer(),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: kTextColor),
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              BlocBuilder<MovieRatedBloc, MovieRatedState>(
                builder: (context, state) {
                  if (state.status.isSuccess && state.movieRatedList.isNotEmpty) {
                    final List topFiveMovies = state.movieRatedList.take(5).toList();

                    return SizedBox(
                      height: 300,
                      child: CarouselView.weighted(
                        flexWeights: [1, 7, 1],
                        controller: _controller,
                        children: topFiveMovies.map((movie) {
                          return Container(
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }else if(state.status.isLoading){
                    return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                  }else if(state.status.isFailure){
                   return Center(
                     child: Text(
                       state.message,
                       style: TextStyle(color: Colors.red),
                     ),
                   );
                  }

                  return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                },
              ),






              SectionHeaderRow(
                text: "Top Rated Movies",
                textButton: "see all",
              ),

              BlocConsumer<MovieRatedBloc, MovieRatedState>(
                listener: (context, state) {
                  if (state.status.isFailure) {
                    print(state.message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.status.isFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state.status.isSuccess) {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.movieRatedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.movieRatedList[index].id,
                                      mediaType: "movie",
                                    )
                                  )
                                );
                              },
                              child: CustomListView(
                                imageUrl: "https://image.tmdb.org/t/p/w500${state.movieRatedList[index].posterPath}",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text("No Data", style: TextStyle(color: Colors.red)),
                  );
                },
              ),


              const SizedBox(height: 20,),

              SectionHeaderRow(
                text: "top Rated Tv Shows",
                textButton: "see all",
              ),

              BlocConsumer<TvRatedBloc, TvRatedState>(
                listener: (context, state){
                  if(state.status.isFailure){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                },
                builder: (context, state){
                  if(state.status.isLoading){
                    return Center(child: CircularProgressIndicator());
                  }else if(state.status.isFailure){
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    );
                  }else if(state.status.isSuccess){
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.tvRatedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.tvRatedList[index].id,
                                      mediaType: "tv",
                                    )
                                  )
                                );
                              },
                              child: CustomListView(
                                imageUrl: "https://image.tmdb.org/t/p/w500${state.tvRatedList[index].posterPath}",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text("No Data", style: TextStyle(color: Colors.red)),
                  );
                },
              ),


              const SizedBox(height: 20,),

              SectionHeaderRow(
                text: "Top Actors",
                textButton: "see all",
              ),


              BlocConsumer<PersonBloc, PersonState>(
                listener: (context, state){
                  if(state.status.isError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                },
                builder: (context, state){
                  if(state.status.isLoading){
                    return Center(child: CircularProgressIndicator());
                  }else if(state.status.isError){
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }else if(state.status.isLoaded){
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.personList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.grey[700],
                                          ),
                                        );
                                      },
                                      "https://image.tmdb.org/t/p/w500${state.personList[index].profilePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Text(
                                  state.personList[index].name,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Text(
                    "No Data",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                },
              ),



            ],
          ),
        ),
      ),
    );
  }
}

class TestScreenSecond extends StatelessWidget {
  const TestScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Test Screen Second",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TalScreen extends StatelessWidget {
  const TalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Test Screen Third",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TolScreen extends StatelessWidget {
  const TolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Test Screen Fourth",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
