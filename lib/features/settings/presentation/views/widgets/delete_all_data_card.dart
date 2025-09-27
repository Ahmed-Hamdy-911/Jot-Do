import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/custom_list_title.dart';

class DeleteAllDataCard extends StatelessWidget {
  const DeleteAllDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomCard(
      child: CustomListTitle(
        contentPadding: const EdgeInsetsDirectional.only(start: 18),
        title: S.of(context).delete_all_data,
        leadingIcon: IconlyBroken.delete,
        noTrailing: true,
        subTitleWidget: RichText(
          text: TextSpan(
            text: S.of(context).warn_delete_1,
            style: AppConstants.bodySmallStyle(colors.textSecondary),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: AlignmentDirectional.bottomCenter,
                  ),
                  child: Text(
                    S.of(context).more_details,
                    style: TextStyle(
                      color: colors.blue,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
