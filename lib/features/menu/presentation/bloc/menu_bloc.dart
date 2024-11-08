import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
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
  }
}
