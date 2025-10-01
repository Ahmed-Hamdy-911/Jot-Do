import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../constants/colors/smart_app_color.dart';
import 'custom_text_form.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomTextFormField(
        filled: true,
        keyboardType: TextInputType.text,
        fillColor: colors.fillColor,
        controller: controller,
        hintText: hintText,
        prefixIcon: const Icon(IconlyLight.search),
      ),
    );
  }
}
