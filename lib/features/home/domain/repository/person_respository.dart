import '../entities/person_entities.dart';

abstract class PersonRepository {
  Future<List<PersonEntity>> getPerson();
}