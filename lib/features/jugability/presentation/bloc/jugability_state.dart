part of 'jugability_bloc.dart';

sealed class JugabilityState extends Equatable {
  const JugabilityState();
  
  @override
  List<Object> get props => [];
}

final class JugabilityInitial extends JugabilityState {}

final class JugabilityLoading extends JugabilityState {}

final class JugabilityLoaded extends JugabilityState {
  final RoundInfo roundInfo;

  const JugabilityLoaded({required this.roundInfo});
}

final class JugabilityNewRound extends JugabilityState {
  final String actualMonth;

  const JugabilityNewRound({required this.actualMonth});
}

final class JugabilityFinish extends JugabilityState {}

final class JugabilityFailure extends JugabilityState {}

final class JugabilityTimerExpired extends JugabilityState {
  final List<Meal> currentMeals;

  const JugabilityTimerExpired({required this.currentMeals});
}

final class RoundInfoAfterTimeExpiration extends JugabilityState {
  final RoundInfo roundInfo;

  const RoundInfoAfterTimeExpiration({required this.roundInfo});
}
