import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final int? count;

  const MenuItemModel({
    required this.title,
    this.icon,
    this.onTap,
    this.count,
  });
}
