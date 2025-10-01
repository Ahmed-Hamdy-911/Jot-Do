import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar(
      {super.key, this.notesLength = 0, this.tasksLength = 0, this.index = 0});
  final int index;
  final int? notesLength, tasksLength;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).appName,
            style: AppConstants.appNameStyle(colors.textPrimary),
          ),
          Text(
            index == context.watch<TopBodyNaviCubit>().state
                ? "($notesLength) ${S.of(context).notes}"
                : "($tasksLength) ${S.of(context).tasks}",
            style: AppConstants.captionStyle(colors.textPrimary),
          ),
        ],
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          tooltip: S.of(context).syncNow,
          onPressed: () {},
          icon: Icon(
            Icons.cloud_sync_outlined,
            color: colors.textPrimary,
          ),
        ),
        if (Platform.isAndroid || Platform.isIOS)
          IconButton(
            padding: EdgeInsets.zero,
            tooltip: S.of(context).search,
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: colors.textPrimary,
            ),
          ),
        IconButton(
          padding: EdgeInsets.zero,
          tooltip: S.of(context).settings,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.settings);
          },
          icon: Icon(
            IconlyLight.setting,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
