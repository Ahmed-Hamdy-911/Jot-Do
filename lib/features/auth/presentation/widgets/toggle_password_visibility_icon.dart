import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors/smart_app_color.dart';
import '../cubit/auth_cubit.dart';

class TogglePasswordVisibilityIcon extends StatelessWidget {
  final bool isConfirmField;
  const TogglePasswordVisibilityIcon({super.key, required this.isConfirmField});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isVisible = isConfirmField
        ? cubit.isConfirmPasswordVisible
        : cubit.isPasswordVisible;
    var colors = SmartAppColor(context);
    return IconButton(
      onPressed: () {
        if (isConfirmField) {
          context.read<AuthCubit>().toggleConfirmPasswordVisibility();
        } else {
          context.read<AuthCubit>().togglePasswordVisibility();
        }
      },
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: colors.grey,
      ),
    );
  }
}
