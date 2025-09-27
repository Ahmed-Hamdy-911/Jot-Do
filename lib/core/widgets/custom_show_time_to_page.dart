import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../constants/app_constants.dart';
import '../constants/colors/smart_app_color.dart';
import '../services/format_service.dart';
import 'components.dart';
import 'custom_text_form.dart';

class CustomShowTimeToPage extends StatelessWidget {
  const CustomShowTimeToPage(
      {super.key,
      required this.createdAt,
      this.updatedAt,
      required this.isUpdating});
  final String createdAt;
  final String? updatedAt;
  final String? isUpdating;
  @override
  Widget build(BuildContext context) {
    final formatCreatedAt = FormatService.formatDateTime(createdAt);
    final formatUpdatedAt =
        isUpdating != null ? FormatService.formatDateTime(updatedAt) : null;
    TextStyle? customInputStyle =
        AppConstants.bodySmallStyle(SmartAppColor(context).textSecondary);
    return Column(
      children: [
        CustomTextFormField(
          customBorder: const UnderlineInputBorder(),
          initialValue: formatCreatedAt,
          customInputStyle: customInputStyle,
          labelText: S.of(context).created_at,
          enabled: false,
        ),
        AppComponents.mediumVerticalSpace(),
        if (isUpdating != null)
          CustomTextFormField(
            customBorder: const UnderlineInputBorder(),
            initialValue: formatUpdatedAt,
            labelText: S.of(context).last_updated,
            customInputStyle: customInputStyle,
            enabled: false,
          ),
      ],
    );
  }
}
