import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'jugability_event.dart';
part 'jugability_state.dart';

class JugabilityBloc extends Bloc<JugabilityEvent, JugabilityState> {
  JugabilityBloc() : super(JugabilityInitial()) {
    on<LoadGameEvent>((event, emit) {
      emit(JugabilityLoading());
      try {
        emit(JugabilityLoaded());
      } catch (e) {
        emit(JugabilityFailure());
      }
    });
  }
}
