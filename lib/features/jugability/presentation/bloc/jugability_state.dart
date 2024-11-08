part of 'jugability_bloc.dart';

sealed class JugabilityState extends Equatable {
  const JugabilityState();
  
  @override
  List<Object> get props => [];
}

final class JugabilityInitial extends JugabilityState {}
