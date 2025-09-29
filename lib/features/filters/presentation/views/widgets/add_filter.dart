import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/pick_color/pick_color_cubit.dart';
import 'add_filter_form.dart';

class AddFilter extends StatelessWidget {
  const AddFilter(
      {super.key, this.isInBottomSheet = false, required this.parentContext,
  });
  final bool isInBottomSheet;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var colors = SmartAppColor(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenSize.width,
          constraints: BoxConstraints(
              maxWidth: screenSize.width >= 600 ? 600 : screenSize.width),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            color: colors.backgroundScreen,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          color: colors.primary,
                          size: AppConstants.scaledSp(22),
                        ),
                        AppComponents.mediumHorizontalSpace(),
                        Text(
                          S.of(context).createFilter,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: AppConstants.scaledSp(18),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            inherit: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                S.of(context).createFilterDescription,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: AppConstants.scaledSp(12),
                  decoration: TextDecoration.none,
                  inherit: false,
                ),
              ),
              AppComponents.largeVerticalSpace(),
              BlocProvider(
                create: (context) => PickColorCubit(colors),
                child: Builder(builder: (context) {
                  return AddFilterForm(
                   
                    isInBottomSheet: isInBottomSheet,
                    parentContext: parentContext,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
