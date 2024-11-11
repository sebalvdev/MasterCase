part of 'jugability_bloc.dart';

sealed class JugabilityState extends Equatable {
  const JugabilityState();
  
  @override
  List<Object> get props => [];
}

final class JugabilityInitial extends JugabilityState {}

final class JugabilityLoading extends JugabilityState {}

final class JugabilityLoaded extends JugabilityState {
  final List<String> menu;
  final String month;

  const JugabilityLoaded({required this.menu, required this.month});
}

final class JugabilityFailure extends JugabilityState {}