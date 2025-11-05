import 'package:flutter/material.dart';
import 'widgets/app_bar_enter_code.dart';
import 'widgets/enter_code_widget.dart';
import 'widgets/scan_qr_code_widget.dart';

class EnterCodeView extends StatefulWidget {
  const EnterCodeView({super.key});

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();
}

class _EnterCodeViewState extends State<EnterCodeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            setState(() {});
          }
        });
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 35),
            child: AppBarEnterCode(tabController: tabController),
          ),
          body: TabBarView(
            controller: tabController,
            children: const [
              EnterCodeWidget(),
              ScanQRCodeWidget(),
            ],
          ),
        );
      }),
    );
  }
}

// class ScanQRCodeWidget extends StatefulWidget {
//   final ValueChanged<String>? onScanned;
//   const ScanQRCodeWidget({Key? key, this.onScanned}) : super(key: key);

//   @override
//   State<ScanQRCodeWidget> createState() => _ScanQRCodeWidgetState();
// }

// class _ScanQRCodeWidgetState extends State<ScanQRCodeWidget> {
//   // Use DetectionSpeed.noDuplicates to reduce duplicate detections.
//   final MobileScannerController _controller = MobileScannerController(
//     detectionSpeed: DetectionSpeed.noDuplicates,
//     torchEnabled: false,
//     facing: CameraFacing.back,
//   );

//   bool _processing = false; // local guard
//   StreamSubscription<BarcodeCapture>? _barcodeSub;
//   late CameraFacing _facing;
//   late TorchState _torchState;

//   @override
//   void initState() {
//     super.initState();
//     // initialize local state from controller.value (may be uninitialized initially)
//     _facing = _controller.value.cameraDirection;
//     _torchState = _controller.value.torchState;

//     // Option A: listen to barcodes stream from controller (advanced lifecycle handling)
//     // _barcodeSub = _controller.barcodes.listen(_handleCapture);

//     // We will also listen to controller changes so UI updates from state changes (camera/toggle).
//     _controller.addListener(_onControllerChanged);
//   }

//   void _onControllerChanged() {
//     // keep UI in sync
//     final val = _controller.value;
//     setState(() {
//       _facing = val.cameraDirection;
//       _torchState = val.torchState;
//     });
//   }

//   @override
//   void dispose() {
//     _barcodeSub?.cancel();
//     _controller.removeListener(_onControllerChanged);
//     _controller.dispose();
//     super.dispose();
//   }

//   // This method handles BarcodeCapture from MobileScanner.onDetect
//   Future<void> _handleCapture(BarcodeCapture capture) async {
//     if (_processing) return;
//     final List<Barcode> barcodes = capture.barcodes;
//     if (barcodes.isEmpty) return;

//     final raw = barcodes.first.rawValue;
//     if (raw == null || raw.isEmpty) return;

//     _processing = true;
//     try {
//       // pause camera (stop reading frames) to avoid double-callbacks
//       await _controller.stop();

//       // callback back to parent
//       widget.onScanned?.call(raw);

//       // optional UI feedback
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Scanned: $raw'),
//               duration: const Duration(seconds: 2)),
//         );
//       }

//       // short delay then resume scanning (or navigate away instead)
//       await Future.delayed(const Duration(milliseconds: 800));
//       if (mounted) {
//         await _controller.start();
//       }
//     } finally {
//       _processing = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // MobileScanner widget: onDetect returns BarcodeCapture
//         MobileScanner(
//           controller: _controller,
//           onDetect: _handleCapture,
//         ),

//         // overlay: scan window
//         Align(
//           alignment: Alignment.center,
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.7,
//             height: MediaQuery.of(context).size.width * 0.7,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.9), width: 2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),

//         // top controls
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // close/back
//                 IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white),
//                   onPressed: () => Navigator.of(context).maybePop(),
//                 ),

//                 Row(
//                   children: [
//                     // torch toggle: check controller.value.torchState
//                     IconButton(
//                       icon: Icon(
//                         _torchState == TorchState.on
//                             ? Icons.flash_on
//                             : Icons.flash_off,
//                         color: Colors.white,
//                       ),
//                       onPressed: () async {
//                         await _controller.toggleTorch();
//                         // controller.value.torchState will be updated; listener will update _torchState
//                       },
//                     ),

//                     // switch camera
//                     IconButton(
//                       icon: Icon(
//                         _facing == CameraFacing.back
//                             ? Icons.cameraswitch
//                             : Icons.camera_alt,
//                         color: Colors.white,
//                       ),
//                       onPressed: () async {
//                         await _controller.switchCamera();
//                         // controller.value.cameraDirection will update; listener will update _facing
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // bottom helper text
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 36),
//             child: Text(
//               'Point the camera at a QR code',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
