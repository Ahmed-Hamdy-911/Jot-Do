import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/pick_color_grid_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/cubits/bottom_sheet_cubit/bottom_sheet_cubit.dart';
import '../../../data/models/filter_model.dart';
import '../../cubits/filter/filter_cubit.dart';
import '../../cubits/pick_color/pick_color_cubit.dart';

class AddFilterForm extends StatefulWidget {
  const AddFilterForm(
      {super.key, this.isInBottomSheet = false, required this.parentContext});
  final bool isInBottomSheet;
  final BuildContext parentContext;
  @override
  State<AddFilterForm> createState() => _AddFilterFormState();
}

class _AddFilterFormState extends State<AddFilterForm> {
  @override
  void initState() {
    context.read<PickColorCubit>().reset();
    super.initState();
  }

  final _filterNameController = TextEditingController();

  final helperErrorText = ValueNotifier<String?>(null);
  void validate() async {
    var collection = widget.parentContext.read<FilterCubit>().state.filters;

    final name = _filterNameController.text.trim();

    if (name.isEmpty) {
      helperErrorText.value = S.of(context).error_required_field;
    } else if (name.length < 3) {
      helperErrorText.value = S.of(context).error_short_name;
    } else if (name.length > 20) {
      helperErrorText.value = S.of(context).error_long_name;
    } else if (RegExp(r'^[0-9]').hasMatch(name)) {
      helperErrorText.value = S.of(context).error_name_starts_with_number;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
      helperErrorText.value =
          S.of(context).error_name_contains_special_characters;
    } else if (collection
        .any((f) => f.name.toLowerCase() == name.toLowerCase())) {
      helperErrorText.value = S.of(context).error_name_already_exists;
    } else {
      helperErrorText.value = null;

      var filterModel = FilterModel(
        name: name,
        color: context.read<PickColorCubit>().state.selectedColor.toARGB32(),
        createdAt: DateTime.now().toIso8601String(),
      );

      log('Filter Model: ${filterModel.name}, Color: ${filterModel.color}, Created At: ${filterModel.createdAt}');
      widget.parentContext.read<FilterCubit>().addFilter(filterModel);
      Navigator.pop(context);
      if (widget.isInBottomSheet) {
        widget.parentContext.read<BottomSheetCubit>().openFilterSheet(
              widget.parentContext,
              title: S.of(context).filter_notes,
              icon: IconlyLight.document,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final filterColor =
        context.watch<PickColorCubit>().state.selectedColor.toARGB32();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).filterName,
          style: AppConstants.filterStyle(colors.textPrimary),
        ),
        AppComponents.smallVerticalSpace(),
        ValueListenableBuilder(
            valueListenable: helperErrorText,
            builder: (context, value, child) {
              return CustomTextFormField(
                filled: true,
                helperText: helperErrorText.value,
                keyboardType: TextInputType.text,
                helperTextColor: Color(filterColor),
                fillColor: colors.fillColor,
                controller: _filterNameController,
                hintText: S.of(context).filterNamePlaceholder,
                customBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.kRadius),
                  borderSide: BorderSide.none,
                ),
              );
            }),
        AppComponents.smallVerticalSpace(),
        const PickColorGridView(),
        AppComponents.mediumVerticalSpace(),
        Text(
          S.of(context).preview,
          style: AppConstants.filterStyle(colors.textPrimary),
        ),
        ValueListenableBuilder<TextEditingValue>(
            valueListenable: _filterNameController,
            builder: (context, value, child) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colors.fillColor,
                  borderRadius: BorderRadius.circular(AppConstants.kRadius),
                ),
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          context.watch<PickColorCubit>().state.selectedColor,
                      borderRadius:
                          BorderRadius.circular(AppConstants.kRadius - 6),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      value.text.isEmpty
                          ? S.of(context).previewFilterName
                          : value.text,
                      style: AppConstants.bodySmallStyle(colors.textPrimary),
                    ),
                  ),
                ),
              );
            }),
        AppComponents.mediumVerticalSpace(),
        SizedBox(
          height: 45,
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                    text: S.of(context).cancel,
                    onPressed: () => Navigator.pop(context),
                    bgColor: colors.backgroundScreen,
                    borderColor: colors.border,
                    style: AppConstants.bodySmallStyle(colors.textPrimary)),
              ),
              AppComponents.smallHorizontalSpace(),
              Expanded(
                child: CustomButton(
                    text: S.of(context).createFilter,
                    onPressed: _filterNameController.text.isEmpty
                        ? null
                        : () {
                            validate();
                          },
                    bgColor: colors.reverseBackgroundColor,
                    borderColor: colors.border,
                    style:
                        AppConstants.bodySmallStyle(colors.reverseTextColor)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
