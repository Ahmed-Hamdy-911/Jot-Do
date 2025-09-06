import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';

class AuthExcitedText extends StatelessWidget {
  const AuthExcitedText({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var textColor = darkMode ? AppColor.white70 : AppColor.blackColor;
    return Center(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.colorScheme,
              fontWeight: FontWeight.bold,
              fontSize:
                  screenWidth < 600 ? screenWidth * 0.045 : screenWidth * 0.03,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: textColor,
              fontSize:
                  screenWidth < 600 ? screenWidth * 0.035 : screenWidth * 0.02,
            ),
          ),
          const LargeSpace(),
        ],
      ),
    );
  }
}
