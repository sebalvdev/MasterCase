part of 'names_bloc.dart';

sealed class NamesEvent extends Equatable {
  const NamesEvent();

  @override
  List<Object> get props => [];
}

class LoadNamesEvent extends NamesEvent {}

class StartGameEvent extends NamesEvent {
  final List<String> players;

  const StartGameEvent({required this.players});
}
