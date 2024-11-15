// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/core/utilities/utilities.dart';
import 'package:master_case/features/scanner_qr/presentation/bloc/scanner_qr_bloc.dart';
import 'package:master_case/features/scanner_qr/presentation/widgets/qr_scan_result_dialog.dart';
import 'package:master_case/features/scanner_qr/presentation/widgets/qr_scanner_overlay.dart';
import 'package:master_case/injection_container.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode],
  );
  bool isScanEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Case App',
            style: TextStyle(color: Colors.white)),
        elevation: 1,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: buildBody(context),
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScannerQrBloc>(),
      child:
          BlocBuilder<ScannerQrBloc, ScannerQrState>(builder: (context, state) {
        if (state is OutsideQrCodeValidated) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            isScanEnabled = false; // Deshabilita el escaneo
            await scannedQrDialog(context, state.isQrCodeValidated);
            if (state.isQrCodeValidated) {
              //Redirecciona hacia la pantalla de jugabilidad si el codigo qr
              //es valido

              final Utilities utilities = Utilities();
              utilities.setUserLogged();

              Navigator.of(context).pushNamedAndRemoveUntil(
                '/game',
                (Route<dynamic> route) =>
                    false, // Elimina todas las pantallas anteriores
              );
              isScanEnabled = false; // Habilita el escaneo de nuevo
            } else {
              isScanEnabled =
                  true; // Habilita el escaneo de nuevo si no es válido
            }
          });
        }

        if (state is ScannerQrError) {
          // Permitir reintentar el escaneo tras el error
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isScanEnabled = true; // Rehabilitar el escaneo
          });
        }
        return SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Transform.rotate(
                  angle: 4.71,
                  child: MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) {
                      if (isScanEnabled) {
                        isScanEnabled =
                            false; // Deshabilita el escaneo al detectar
                        var qrCaptured = capture.barcodes[0];
                        if (state is ScannerQrInitial ||
                            state is ScannerQrError) {
                          BlocProvider.of<ScannerQrBloc>(context).add(
                            ValidateQRCodeEvent(
                                outsideQRCode: qrCaptured.displayValue ?? ''),
                          );
                        }
                      }
                    },
                    overlayBuilder: (context, constraints) {
                      return Container(
                        decoration: ShapeDecoration(
                          shape: QrScannerOverlayShape(
                              borderColor: Colors.white,
                              borderRadius: 10,
                              borderLength: 25,
                              borderWidth: 7.5,
                              cutOutSize:
                                  MediaQuery.of(context).size.width * 0.35),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  bottom: 150,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          "Valida tu aplicacion de master case!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                  ))),
              if (state is ScannerQrLoading) ...[
                // Capa semitransparente para opacar la interfaz
                const Opacity(
                  opacity: 0.5, // Ajusta la opacidad según lo necesites
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              ],
              if (state is ScannerQrError)
                const Center(
                  child: Text(
                    'Error al escanear el QR. Inténtalo de nuevo.',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> scannedQrDialog(BuildContext context, bool isScanCorrect) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          QRScanResultDialog(isScanCorrect: isScanCorrect),
    );
  }
}
