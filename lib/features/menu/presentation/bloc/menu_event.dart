part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadMenuEvent extends MenuEvent {}

class LoadSecondMenuEvent extends MenuEvent {}
