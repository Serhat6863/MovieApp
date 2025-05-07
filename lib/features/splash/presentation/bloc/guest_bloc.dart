import 'package:bloc/bloc.dart';
import 'package:movie_app/features/splash/data/repository/guest_session_repository_impl.dart';
import 'package:movie_app/features/splash/domain/entities/guest_session_entities.dart';
import 'package:movie_app/features/splash/presentation/bloc/guest_envent.dart';
import 'package:movie_app/features/splash/presentation/bloc/guest_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState>{
  final GuestSessionRepositoryImpl guestSessionRepositoryImpl;
  final SharedPreferences sharedPreferences;

  GuestBloc({required this.sharedPreferences ,required this.guestSessionRepositoryImpl}): super(GuestState.initial()){
    on<GetGuestSessionEvent>(_getGuestSession);
    on<DeleteGuestSessionEvent>(_deleteGuestSession);
  }


  Future<void> _getGuestSession(GetGuestSessionEvent event, Emitter<GuestState> emit) async{
    emit(GuestState.loading());
    try{

      final cacheId = sharedPreferences.getString('guestSessionId');
      print("cacheId $cacheId");
      if(cacheId != null){
        final entitiy = GuestSessionEntity(
          guestSessionId: cacheId,
          expiresAt: DateTime.now(),
        );
        emit(GuestState.loaded(entitiy));
      }

      final guestSessionId = await guestSessionRepositoryImpl.createGuestSession();
      final saved = await sharedPreferences.setString('guestSessionId', guestSessionId.guestSessionId);
      print("saved $saved");
      if(!saved){
        emit(GuestState.error("Failed to save guest session id"));
        return;
      }
      emit(GuestState.loaded(guestSessionId));
    }catch(e){
      emit(GuestState.error(e.toString()));
    }
  }

  Future<void> _deleteGuestSession(DeleteGuestSessionEvent event, Emitter<GuestState> emit) async{
    emit(GuestState.loading());
    try{
      await sharedPreferences.remove('guestSessionId');
      emit(GuestState.initial());
    }catch(e){
      emit(GuestState.error(e.toString()));
    }
  }

}