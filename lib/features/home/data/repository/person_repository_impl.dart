import 'package:movie_app/features/home/data/model/person_model.dart';
import 'package:movie_app/features/home/domain/entities/person_entities.dart';
import 'package:movie_app/features/home/domain/repository/person_respository.dart';

import '../../../../core/constant.dart';
import '../api/media_api.dart';

class PersonRepositoryImpl implements PersonRepository{

  final MediaApi mediaApi;

  PersonRepositoryImpl({required this.mediaApi});

  @override
  Future<List<PersonEntity>> getPerson() async {
    try{
      final response = await mediaApi.getPerson(
        'en-US',
        "Bearer $kApiKey",
        'day',
      );


      if(response.response.statusCode != 200){
        throw Exception("failed to load person");
      }

      final data = response.data as Map<String , dynamic>;
      final List<PersonModel> results = (data['results'] as List).map((person) => PersonModel.fromJson(person)).toList();
      return results;

    }catch(e){
      throw Exception("failed to load person : $e");
    }
  }

}