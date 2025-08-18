import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jot_do/core/constants/constant.dart';
import '../../../../../../generated/l10n.dart';

ActionPane onDismissibleStartAction(context) => ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => null,
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: S.of(context).delete,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppConstants.kRadius),
            bottomRight: Radius.circular(AppConstants.kRadius),
          ),
        ),
      ],
    );
ActionPane onDismissibleEndAction(context) => ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => null,
          backgroundColor: const Color(0xFF26A69A),
          foregroundColor: Colors.white,
          icon: Icons.push_pin,
          label: S.of(context).pin,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.kRadius),
            bottomLeft: Radius.circular(AppConstants.kRadius),
          ),
        ),
        SlidableAction(
          onPressed: (context) => null,
          backgroundColor: Colors.blueGrey.shade500,
          foregroundColor: Colors.white,
          icon: Icons.archive,
          label: S.of(context).archive,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.kRadius),
            bottomLeft: Radius.circular(AppConstants.kRadius),
          ),
        ),
      ],
    );
