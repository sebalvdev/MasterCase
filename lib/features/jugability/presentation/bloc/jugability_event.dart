part of 'jugability_bloc.dart';

sealed class JugabilityEvent extends Equatable {
  const JugabilityEvent();

  @override
  List<Object> get props => [];
}

class LoadGameEvent extends JugabilityEvent {}