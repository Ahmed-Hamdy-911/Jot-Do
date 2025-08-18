import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../generated/l10n.dart';

ActionPane onDismissibleStartAction(context) => ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => null,
            backgroundColor: const Color(0xFFE53935),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            icon: Icons.delete,
            label: S.of(context).delete,
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
          ),
          SlidableAction(
            onPressed: (context) => null,
            backgroundColor: Colors.blueGrey.shade500,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: S.of(context).archive,
          ),
        ],
      );