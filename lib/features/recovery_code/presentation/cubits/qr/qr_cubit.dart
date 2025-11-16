import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:bloc/bloc.dart';

import '../../../../../core/services/permissions/permission_model.dart';
import '../../../../../core/services/permissions/permission_service.dart';
import 'qr_state.dart';

class QRScanCubit extends Cubit<QRScanState> {
  MobileScannerController? _controller;
  bool processing = false;

  QRScanCubit() : super(QRScanInitial());

  MobileScannerController _createController() {
    final c = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      torchEnabled: false,
      facing: CameraFacing.back,
      formats: [BarcodeFormat.qrCode],
    );
    c.addListener(_onControllerChanged);
    return c;
  }

  void _onControllerChanged() {
    if (_controller == null || isClosed) return;
    try {
      final val = _controller!.value;
      final bool isBack = val.cameraDirection == CameraFacing.back;
      final bool torchOn = val.torchState == TorchState.on;

      if (state is QRScanPermissionGranted || state is QRControllerChanged) {
        emit(QRControllerChanged(torchOn: torchOn, isBackCamera: isBack));
      }
    } catch (_) {}
  }

  MobileScannerController get controller {
    _controller ??= _createController();
    return _controller!;
  }

  Future<void> checkPermissions() async {
    emit(QRScanInProgress());
    try {
      final granted =
          await PermissionService.requestPermission(AppPermission.camera);
      if (granted) {
        emit(QRScanPermissionGranted());
      } else {
        emit(QRScanPermissionDenied());
      }
    } catch (e) {
      emit(QRScanFailure(e.toString()));
    }
  }

  Future<void> stopScanning() async {
    if (_controller == null) return;
    try {
      await _controller!.stop();
    } catch (_) {}
  }

  Future<void> resumeScanning() async {
    if (isClosed || state is QRScanSuccess) return;
    emit(QRScanPermissionGranted());
  }

  Future<void> onScanSuccess(String code) async {
    if (processing || isClosed) return;
    processing = true;
    try {
      await _controller?.stop();
      emit(QRScanSuccess(code));
    } catch (e) {
      if (!isClosed) {
        emit(QRScanError(e.toString()));
        reScan();
      }
    } finally {
      processing = false;
    }
  }

  Future<void> reScan() async {
    if (isClosed) return;
    try {
      await _disposeController();
      emit(QRScanPermissionGranted());
    } catch (e) {
      if (!isClosed) {
        emit(QRScanError('Failed to restart: $e'));
      }
    }
  }

  Future<void> _disposeController() async {
    if (_controller == null) return;
    try {
      _controller!.removeListener(_onControllerChanged);
      await _controller!.stop();
      await _controller!.dispose();
    } catch (_) {}
    _controller = null;
  }

  Future<void> killController() async {
    await _disposeController();
  }

  @override
  Future<void> close() async {
    await _disposeController();
    return super.close();
  }
}
