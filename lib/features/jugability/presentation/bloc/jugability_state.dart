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
final class JugabilityFinish extends JugabilityState {}

final class JugabilityFailure extends JugabilityState {}