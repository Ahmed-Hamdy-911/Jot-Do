import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../../generated/l10n.dart';
import 'setting_card.dart';
import 'setting_item.dart';

class DeleteAllDataCard extends StatelessWidget {
  const DeleteAllDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    return CustomSettingCard(
      child: CustomSettingItem(
        contentPadding: const EdgeInsetsDirectional.only(start: 18),
        title: S.of(context).delete_all_data,
        leadingIcon: IconlyBroken.delete,
        noTrailing: true,
        subTitleWidget: RichText(
          text: TextSpan(
            text: S.of(context).warn_delete_1,
            style: TextStyle(
              color: darkMode ? AppColor.white70 : AppColor.grey600,
              fontSize: 13,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    S.of(context).more_details,
                    style: const TextStyle(
                      color: AppColor.blueLightColor,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {

        },
      ),
    );
  }
}
