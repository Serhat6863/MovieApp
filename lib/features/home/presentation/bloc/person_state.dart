import 'package:equatable/equatable.dart';

import '../../domain/entities/person_entities.dart';

enum PersonStatus { initial, loading, success, failure }


extension PersonStateX on PersonStatus {
  bool get isInitial => this == PersonStatus.initial;
  bool get isLoading => this == PersonStatus.loading;
  bool get isLoaded => this == PersonStatus.success;
  bool get isError => this == PersonStatus.failure;
}


class PersonState extends Equatable{
  final PersonStatus status;
  final String message;
  final List<PersonEntity> personList;

  const PersonState({
    required this.status,
    required this.message,
    required this.personList,
  });


  factory PersonState.initial() => PersonState(
    status: PersonStatus.initial,
    message: '',
    personList: [],
  );

  factory PersonState.loading() => PersonState(
    status: PersonStatus.loading,
    message: '',
    personList: [],
  );

  factory PersonState.success(List<PersonEntity> personList) => PersonState(
    status: PersonStatus.success,
    message: '',
    personList: personList,
  );

  factory PersonState.failure(String message) => PersonState(
    status: PersonStatus.failure,
    message: message,
    personList: [],
  );

  PersonState copyWith({
    PersonStatus? status,
    String? message,
    List<PersonEntity>? personList,
  }) {
    return PersonState(
      status: status ?? this.status,
      message: message ?? this.message,
      personList: personList ?? this.personList,
    );
  }

  @override
  List<Object> get props => [status, message, personList];
}