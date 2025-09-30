import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';

import '../../cubits/filter/filter_cubit.dart';
import '../filter_view.dart';

PersistentBottomSheetController customFilterBottomSheet(
  BuildContext parentContext, {
  required String title,
  required IconData icon,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  final scaffold = scaffoldKey.currentState!;
  final filterCubit = parentContext.read<FilterCubit>();
  return scaffold.showBottomSheet(
    (sheetContext) {
      final colors = SmartAppColor(sheetContext);
      return BlocProvider.value(
        value: filterCubit,
        child: FilterView(
          colors: colors,
          title: title,
          icon: icon,
        ),
      );
    },
    enableDrag: true,
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 0,
    shape: const RoundedRectangleBorder(),
  );
}
