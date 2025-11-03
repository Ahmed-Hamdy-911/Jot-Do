import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/services/app_session.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import 'copy_button.dart';

class ShowRecoveryWithQRWidget extends StatefulWidget {
  const ShowRecoveryWithQRWidget({super.key});

  @override
  State<ShowRecoveryWithQRWidget> createState() =>
      _ShowRecoveryWithQRWidgetState();
}

class _ShowRecoveryWithQRWidgetState extends State<ShowRecoveryWithQRWidget> {
  @protected
  late QrImage qrImage;
  final recoveryCode = AppSession.instance.pendingRecoveryCode ??
      'AbCd12-EfGh34-IjKl56-MnOp78-QrSt90-UvWx';
  @override
  void initState() {
    super.initState();

    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(recoveryCode);

    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        width: screenSize.width >= 600 ? 600 : screenSize.width * 0.95,
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          color: colors.white,
          borderRadius: BorderRadius.circular(AppConstants.kRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).recovery_code_qr_alt,
                  style: AppConstants.bodyLargeStyle(colors.reverseTextColor),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: PrettyQrView(
                qrImage: qrImage,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrShape.custom(
                    PrettyQrSquaresSymbol(),
                    finderPattern: PrettyQrSmoothSymbol(),
                    alignmentPatterns: PrettyQrDotsSymbol(),
                  ),
                ),
              ),
            ),
            AppComponents.mediumVerticalSpace(),
            Text(
              S.of(context).recovery_code_qr_description,
              style: AppConstants.bodyMediumStyle(colors.grey),
            ),
            AppComponents.mediumVerticalSpace(),
            const CopyButton(),
          ],
        ),
      ),
    );
  }
}
