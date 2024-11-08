import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'jugability_event.dart';
part 'jugability_state.dart';

class JugabilityBloc extends Bloc<JugabilityEvent, JugabilityState> {
  JugabilityBloc() : super(JugabilityInitial()) {
    on<JugabilityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
