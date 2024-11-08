// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../bloc/login_bloc.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ciController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: buildForm(context));
    return Scaffold(body: content());
  }

  BlocProvider<LoginBloc> content() {
    return BlocProvider<LoginBloc>(
      create: (_) => sl<LoginBloc>(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) return const Center(child: CircularProgressIndicator());
          if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await resultDialog(context, state.register, state.message);
              if (state.register) {
                // ignore: use_build_context_synchronously
                Navigator.popAndPushNamed(context, AppRoutes.menu);
                // Navigator.pop(context,
                //     true); // Vuelve a la pantalla anterior si el QR es válido
              } else {
                // state.register =
                //     true; // Habilita el escaneo de nuevo si no es válido
              }
            });
            // state.register ? print('mensaje: ${state.message}') : print('mensaje: ${state.message}');
          }
          return buildForm(context);
        },
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // input para telefono
            // phoneInput(),
            CustomInputField(
              controller: phoneController,
              hintText: '# de celular',
              fontSize: h2,
              icon: Icons.numbers_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // input para carnet
            CustomInputField(
              controller: ciController,
              hintText: 'Ingresa tu carnet',
              fontSize: h2,
              icon: Icons.perm_identity_outlined,
              keyboardType: TextInputType.number,
            ),
            // ciInput(),
            const SizedBox(height: 20),
            createAccountButton(context),
          ],
        ),
      ),
    );
  }

  Widget createAccountButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (phoneController.text.isNotEmpty && ciController.text.isNotEmpty) {
            createAccount(
              context,
              phoneController.text,
              ciController.text,
            );
          } else {
            _showSnackBar(context, "Debe llenar todos los campos.");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text('Continuar', style: TextStyle(color: white, fontSize: h2)),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> resultDialog(
      BuildContext context, bool registered, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          ResultDialog(registered: registered, message: message),
    );
  }
}
