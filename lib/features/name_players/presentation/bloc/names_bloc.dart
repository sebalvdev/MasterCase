import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';

part 'names_event.dart';
part 'names_state.dart';

class NamesBloc extends Bloc<NamesEvent, NamesState> {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  NamesBloc() : super(NamesInitial()) {

    on<LoadNamesEvent>((event, emit) async {
      emit(NamesLoading());
      try {
        emit(NamesLoaded());
      } catch (e) {
        emit(NamesFailure());
      }
    });

    on<StartGameEvent>((event, emit) async {
      emit(NamesLoading());
      try {
        await sharedPreferences.setStringList(cachePlayers, event.players);
        emit(StartGame());
      } catch (e) {
        emit(NamesFailure());
      }
    });
  }
}
