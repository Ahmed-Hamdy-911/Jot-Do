import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final Widget? widget;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final int? count;

  const MenuItemModel({
    required this.title,
    this.widget,
    this.icon,
    this.color,
    this.onTap,
    this.count,
  });
}
