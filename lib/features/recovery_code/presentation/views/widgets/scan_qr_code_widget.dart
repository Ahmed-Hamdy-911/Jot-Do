import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/qr/qr_cubit.dart';
import '../../cubits/qr/qr_state.dart';

class ScanQRCodeWidget extends StatelessWidget {
  const ScanQRCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRScanCubit()..checkPermissions(),
      child: const QrRScannerBuilder(),
    );
  }
}

class QrRScannerBuilder extends StatefulWidget {
  const QrRScannerBuilder({super.key});

  @override
  State<QrRScannerBuilder> createState() => _QrRScannerBuilderState();
}

class _QrRScannerBuilderState extends State<QrRScannerBuilder>
    with WidgetsBindingObserver {
  late final QRScanCubit qrCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    qrCubit = context.read<QRScanCubit>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      qrCubit.stopScanning();
    } else if (state == AppLifecycleState.resumed) {
      qrCubit.resumeScanning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRScanCubit, QRScanState>(
      builder: (context, state) {
        if (state is QRScanInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QRScanPermissionDenied) {
          return Center(
            child: ElevatedButton(
              onPressed: qrCubit.checkPermissions,
              child: const Text('Allow Camera Permission'),
            ),
          );
        } else if (state is QRScanPermissionGranted ||
            state is QRControllerChanged) {
          return const ScannerWidget();
        } else if (state is QRScanSuccess) {
          return _buildSuccessWidget(context, state.result, qrCubit);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSuccessWidget(
      BuildContext context, String result, QRScanCubit cubit) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Result')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Scanned QR Code:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SelectableText(result, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: result));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: cubit.reScan,
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Re-Scan'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScannerWidget extends StatelessWidget {
  const ScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final qrCubit = context.read<QRScanCubit>();
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsetsDirectional.only(top: kToolbarHeight),
      child: AiBarcodeScanner(
        controller: qrCubit.controller,
        useAppLifecycleState: false,
        galleryButtonType: GalleryButtonType.none,
        appBarBuilder: (context, controller) => AppBar(
          toolbarHeight: MediaQuery.of(context).padding.top,
          backgroundColor: Colors.transparent,
          leading: Container(),
        ),
        overlayConfig: const ScannerOverlayConfig(
          lineThickness: 5,
        ),
        onDetect: (BarcodeCapture capture) {
          if (capture.barcodes.isEmpty) return;
          final raw = capture.barcodes.first.rawValue;
          if (raw == null || raw.isEmpty) return;
          qrCubit.onScanSuccess(raw);
        },
        onDispose: () {
          qrCubit.killController();
        },
      ),
    );
  }
}
