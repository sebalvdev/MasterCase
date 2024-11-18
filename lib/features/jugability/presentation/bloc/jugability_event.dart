part of 'jugability_bloc.dart';

sealed class JugabilityEvent extends Equatable {
  const JugabilityEvent();

  @override
  List<Object> get props => [];
}

class LoadGameEvent extends JugabilityEvent {}

class NextRound extends JugabilityEvent {
  final String actualMonth;

  const NextRound({required this.actualMonth});
}

class BetweenRounds extends JugabilityEvent {
  final String actualMonth;

  const BetweenRounds({required this.actualMonth});
}