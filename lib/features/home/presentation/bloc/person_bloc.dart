import 'package:bloc/bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/person_event.dart';
import 'package:movie_app/features/home/presentation/bloc/person_state.dart';

import '../../data/repository/person_repository_impl.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState>{
  final PersonRepositoryImpl personRepositoryImpl;

  PersonBloc({required this.personRepositoryImpl}): super(PersonState.initial()){
    on<GetPersonEvent>(_getPerson);
  }


  Future<void> _getPerson(GetPersonEvent event, Emitter<PersonState> emit) async{
    emit(PersonState.loading());
    try{
      final personList = await personRepositoryImpl.getPerson();
      emit(PersonState.success(personList));
    }catch(e){
      emit(PersonState.failure(e.toString()));
    }
  }
}