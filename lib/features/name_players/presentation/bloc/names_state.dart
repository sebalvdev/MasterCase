part of 'names_bloc.dart';

sealed class NamesState extends Equatable {
  const NamesState();
  
  @override
  List<Object> get props => [];
}

final class NamesLoading extends NamesState {}

final class NamesLoaded extends NamesState {}

final class StartGame extends NamesState {}

final class NamesInitial extends NamesState {}

final class NamesFailure extends NamesState {}