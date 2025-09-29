import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/bottom_sheet_cubit/bottom_sheet_cubit.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.currentPage,
  });
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final isOpenSheet = context.watch<BottomSheetCubit>().state.isOpen;
    return FloatingActionButton(
      backgroundColor: colors.reverseBackgroundColor.withValues(alpha: 0.8),
      foregroundColor: colors.textInverse,
      onPressed: () {
        if (isOpenSheet) {
          Navigator.pop(context);
          return;
        }
        if (currentPage == 0) {
          Navigator.pushNamed(context, AppRoutes.addNote);
        } else {
          Navigator.pushNamed(context, AppRoutes.addTask);
        }
      },
      shape: const CircleBorder(),
      tooltip:
          isOpenSheet ? S.of(context).cancel : S.of(context).add_note_or_task,
      child: Icon(isOpenSheet ? Icons.close : Icons.add),
    );
  }
}
