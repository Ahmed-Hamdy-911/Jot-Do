import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/generated/l10n.dart';

import '../../../../core/constants/constant.dart';
import '../manager/cubits/onBoarding/on_boarding_cubit.dart';

class CustomSkipButton extends StatelessWidget {
  const CustomSkipButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          top: 20,
          end: 16,
        ),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              S.of(context).skip,
              style: TextStyle(
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
