import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/features/home/presentation/bloc/movie_rated_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/tv_rated_bloc.dart';

import '../bloc/movie_rated_event.dart';
import '../bloc/movie_rated_state.dart';
import '../bloc/tv_rated_event.dart';
import '../bloc/tv_rated_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.mediaType,});

  final int id;
  final String mediaType;


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  void verifyMediaType(String mediaType){
    if(mediaType == "movie"){
      context.read<MovieRatedBloc>().add(GetMovieRatedEventById(widget.id));
    }else if(mediaType == "tv"){
      context.read<TvRatedBloc>().add(GetTvRatedEventById(widget.id));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyMediaType(widget.mediaType);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          "Detail",
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: widget.mediaType == "movie" ?
        BlocBuilder<MovieRatedBloc, MovieRatedState>(
          builder: (context, state){
            if(state.status.isLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state.status.isFailure){
              return Center(child: Text(state.message , style: const TextStyle(color: Colors.red),));
            }else if(state.status.isDetail && state.movieRatedDetail != null){
              final movie = state.movieRatedDetail!;


              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                  
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                  
                  
                      const SizedBox(height: 20,),
                  
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                  
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                  
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                "release date : ${movie.releaseDate}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                "original title : ${movie.originalTitle}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                "original language : ${movie.originalLanguage}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                "vote average : ${movie.voteAverage}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                "Overview",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              const SizedBox(height: 10,),
                  
                              Text(
                                movie.overview,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              const SizedBox(height: 10,),


                              Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Add to favorite",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                  
                  
                            ],
                          ),
                        ),
                      ),
                  
                    ],
                  ),
                ),
              );
            }else{
              return const Center(child: Text("Aucun film trouvé"));
            }

          },
        )
            : BlocBuilder<TvRatedBloc , TvRatedState>(
          builder: (context , state){
            if(state.status.isLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state.status.isFailure){
              return Center(child: Text(state.message , style: const TextStyle(color: Colors.red),));
            }else if(state.status.isDetail){
              final tv = state.tvRated!;

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          tv.posterPath.isNotEmpty ?
                          "https://image.tmdb.org/t/p/w500${tv.posterPath}" :
                          "https://image.tmdb.org/t/p/w500${tv.backdropPath}",
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),


                      const SizedBox(height: 20,),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                tv.name,
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                "first air date : ${tv.firstAirDate}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                "original title : ${tv.originalName}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                "original language : ${tv.originalLanguage}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                "vote average : ${tv.voteAverage}",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                "Overview",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Text(
                                tv.overview,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              const SizedBox(height: 10,),


                              Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Add to favorite",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text("Aucun film trouvé"));
          },
        )
        )
      );
  }
}
