class QRScanState {}

class QRScanInitial extends QRScanState {}

class QRScanPermissionDenied extends QRScanState {}

class QRScanPermissionGranted extends QRScanState {}

class QRScanInProgress extends QRScanState {}

class QRScanSuccess extends QRScanState {
  final String result;
  QRScanSuccess(this.result);
}

class QRScanError extends QRScanState {
  final String message;
  QRScanError(this.message);
}

class QRScanFailure extends QRScanState {
  final String message;
  QRScanFailure(this.message);
}

class QRControllerChanged extends QRScanState {
  final bool torchOn;
  final bool isBackCamera;

  QRControllerChanged({
    this.torchOn = false,
    this.isBackCamera = true,
  });

  QRControllerChanged copyWith({
    bool? torchOn,
    bool? isBackCamera,
  }) {
    return QRControllerChanged(
      torchOn: torchOn ?? this.torchOn,
      isBackCamera: isBackCamera ?? this.isBackCamera,
    );
  }
}
