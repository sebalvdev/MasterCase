import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  MenuBloc() : super(MenuInitial()) {
    on<LoadMenuEvent>((event, emit) async {
      emit(MenuLoading());
      try {
        // await Future.delayed(const Duration(seconds: 2));
        emit(MenuLoaded());
      } catch (e) {
        emit(MenuFailure());
      }
    });

    on<LoadSecondMenuEvent>((event, emit) async {
      emit(MenuLoading());
      try {
        // await Future.delayed(const Duration(seconds: 2));
        emit(SecondMenuLoaded());
      } catch (e) {
        emit(MenuFailure());
      }
    });

    on<GetNamesEvent>((event, emit) async {
      emit(MenuLoading());
      try {
        await sharedPreferences.setDouble(cacheDuration, event.duration);
        emit(GetNames(duration: event.duration, players: event.players));
      } catch (e) {
        emit(MenuFailure());
      }
    });
  }
}
