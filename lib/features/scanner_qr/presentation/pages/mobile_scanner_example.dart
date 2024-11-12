import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/features/scanner_qr/presentation/bloc/scanner_qr_bloc.dart';
import 'package:master_case/injection_container.dart';

class QRScannerPageTest extends StatelessWidget {
  const QRScannerPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple scanner')),
      body: Center(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<ScannerQrBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScannerQrBloc>(),
      child: Center(
        child: BlocBuilder<ScannerQrBloc, ScannerQrState>(
          builder: (context, state) {
            
            if (state is ScannerQrInitial) {
              BlocProvider.of<ScannerQrBloc>(context).add(
                  const ValidateQRCodeEvent(outsideQRCode: '123455')
              );
              return const Text('Scan something!');
            } 
            
            if (state is OutsideQrCodeValidated) {
              return Text('Is QR code validated: ${state.isQrCodeValidated}');
            } 
            
            if (state is ScannerQrError) {
              return Text(state.message);
            }

            return const CircularProgressIndicator();
          } 
        ),
      ),
    );
  }
}