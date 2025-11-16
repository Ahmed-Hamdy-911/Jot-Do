import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/qr/qr_cubit.dart';
import '../../cubits/qr/qr_state.dart';
import '../../cubits/recovery_code/recovery_code_cubit.dart';

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
    return BlocConsumer<QRScanCubit, QRScanState>(
      listener: (context, state) {
        if (state is QRScanSuccess) {
          final code = state.result;
          final recoveryCubit = context.read<RecoveryCodeCubit>();
          recoveryCubit.enterRecoveryCode(code: code);
        }
      },
      builder: (context, state) {
        if (state is QRScanInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QRScanPermissionDenied) {
          return Center(
            child: TextButton(
              onPressed: qrCubit.checkPermissions,
              child: Text(S.of(context).error),
            ),
          );
        } else if (state is QRScanPermissionGranted ||
            state is QRControllerChanged) {
          return const ScannerWidget();
        }
        if (state is QRScanFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        return Center(child: AppComponents.customCircleLoading(context));
      },
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
          // qrCubit.killController();
        },
      ),
    );
  }
}
