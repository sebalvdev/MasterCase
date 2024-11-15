part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {}

final class MenuLoading extends MenuState {}

final class MenuLoaded extends MenuState {}

final class SecondMenuLoaded extends MenuState {}

final class GetNames extends MenuState {
  final double duration;
  final int players;

  const GetNames({required this.duration, required this.players});
}

final class MenuFailure extends MenuState {}
