import 'package:movie_app/features/home/data/api/media_api.dart';
import 'package:movie_app/features/home/data/model/tv_rated_model.dart';
import 'package:movie_app/features/home/domain/entities/tv_rated_entitties.dart';
import 'package:movie_app/features/home/domain/repository/tv_rated_repository.dart';

import '../../../../core/constant.dart';

class TvRatedRepositoryImpl implements TvRatedRepository{

  final MediaApi mediaApi;

  TvRatedRepositoryImpl({required this.mediaApi});

  @override
  Future<List<TvEntity>> getTvRated() async{
    try{
      final response = await mediaApi.getTvRated(
        'en-US',
        "Bearer $kApiKey",
        'day',
      );


      if(response.response.statusCode != 200){
        throw Exception("failed to load tv rated");
      }

      final data = response.data as Map<String , dynamic>;

      final List<TvRatedModel> results = (data['results'] as List).map((tv) => TvRatedModel.fromJson(tv)).toList();

      return results;


    }catch(e){
      throw Exception("failed to load tv rated : $e");
    }
  }

  @override
  Future<TvEntity> getTvDetail(int tvId) async{
    try{
      final response = await mediaApi.getTvDetail(
        tvId,
        "Bearer $kApiKey",
      );


      if(response.response.statusCode != 200){
        throw Exception('Failed to load tv detail');
      }


      final data = response.data;

      return data;

    }catch(e){
      throw Exception('Failed to load tv detail: $e');
    }
  }
  
  
  

}