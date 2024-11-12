// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'jugability_event.dart';
part 'jugability_state.dart';

class JugabilityBloc extends Bloc<JugabilityEvent, JugabilityState> {
  final menuTest = [
    'assets/images/cocina.jpg',
    'assets/images/cocina.jpg',
    'assets/images/cocina.jpg'
  ];
  JugabilityBloc() : super(JugabilityInitial()) {
    on<LoadGameEvent>((event, emit) {
      emit(JugabilityLoading());
      try {
        print('New Round');
        emit(JugabilityLoaded(menu: menuTest, month: 'Enero'));
      } catch (e) {
        emit(JugabilityFailure());
      }
    });
    on<NextRound>((event, emit) {
      emit(JugabilityLoading());
      try {
        print('Next Round');
        emit(JugabilityLoaded(menu: menuTest, month: 'Enero'));
      } catch (e) {
        emit(JugabilityFailure());
      }
    });
  }
}
