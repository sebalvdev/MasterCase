part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;
  final bool register;

  const LoginSuccess({required this.message, required this.register});
}

final class LoginFailure extends LoginState {}
