import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/verify_box.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final VerifyDevice verifyDevice;
  LoginBloc({required this.verifyDevice}) : super(LoginInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(LoginLoading());

      final result = await verifyDevice(Params(data: event.data));
      result.fold(
        (failure) => emit(LoginFailure()), // Maneja el caso de fallo
        (created) => emit(created == "success"
            ? const LoginSuccess(register: true, message: 'success')
            : LoginSuccess(register: false, message: created)),
      );
    });
  }
}
