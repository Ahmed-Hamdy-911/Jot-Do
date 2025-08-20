import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/constant.dart';

class CustomSkipButton extends StatelessWidget {
  const CustomSkipButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          end: 16,
        ),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              S.of(context).skip,
              style: const TextStyle(
                color: AppConstants.colorScheme,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: AppConstants.colorScheme,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}
