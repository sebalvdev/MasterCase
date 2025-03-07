part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends LoginEvent {
  final Map<String, dynamic> data;

  const RegisterEvent({required this.data});
}
