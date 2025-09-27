import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import '../constants/colors/smart_app_color.dart';
import '../models/menu_item_model.dart';
import 'components.dart';
import 'custom_button.dart';
import 'custom_text_form.dart';
import '../../generated/l10n.dart';
import '../constants/app_constants.dart';
import 'custom_material_button.dart';
import '../../features/home/presentation/cubits/top_body_navi/top_body_navi_cubit_.dart';
import '../../features/home/presentation/views/widgets/custom_floating_button.dart';
import 'pick_color_grid_view.dart';

class FilterAndChangeView extends StatelessWidget {
  const FilterAndChangeView({
    super.key,
    required this.isInNotes,
    required this.homeContext,
  });
  final BuildContext homeContext;

  final bool isInNotes;

  @override
  Widget build(BuildContext context) {
    bool isInNotes = context.watch<TopBodyNaviCubit>().state == 0;
    var colors = SmartAppColor(context);
    bool platform =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS
            ? true
            : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
            style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(colors.border),
                foregroundColor: WidgetStatePropertyAll(colors.primary),
                textStyle: WidgetStatePropertyAll(
                    AppConstants.bodyMediumStyle(colors.textPrimary)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.kRadius),
                ))),
            onPressed: () async {
              await customFilterBottomSheet(
                homeContext,
                title: S.of(context).filter_notes,
                icon: IconlyLight.document,
              );
            },
            icon: const Icon(IconlyLight.filter_2),
            label: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: Text(S.of(context).filter_all),
            )),
        Row(
          children: [
            if (!platform)
              CustomMaterialButton(
                height: 25.h,
                minWidth: 20.w,
                radius: AppConstants.kRadius - 4,
                color: isInNotes ? colors.primary : colors.backgroundScreen,
                onPressed: () {},
                widget: Icon(
                  Icons.list,
                  size: 25,
                  color: isInNotes
                      ? colors.backgroundSecondary
                      : colors.textSecondary,
                ),
              ),
            AppComponents.smallHorizontalSpace(),
            CustomMaterialButton(
              height: 25.h,
              minWidth: 20.w,
              onPressed: () {},
              radius: AppConstants.kRadius - 4,
              color: platform
                  ? colors.primary
                  : isInNotes
                      ? colors.backgroundScreen
                      : colors.primary,
              widget: Icon(
                Icons.grid_view_outlined,
                color: platform
                    ? colors.backgroundSecondary
                    : isInNotes
                        ? colors.textSecondary
                        : colors.backgroundSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<dynamic> customFilterBottomSheet(
  BuildContext context, {
  required String title,
  required IconData icon,
}) {
  var colors = SmartAppColor(context);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: false,
    shape: const RoundedRectangleBorder(),
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Container(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  icon,
                                  color: colors.primary,
                                ),
                                AppComponents.mediumHorizontalSpace(),
                                Text(
                                  title,
                                  style: AppConstants.headlineMediumStyle(
                                      colors.textPrimary),
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
                    ),
                    AppComponents.mediumVerticalSpace(),
                    Text(
                      S.of(context).default_filters,
                      style: AppConstants.bodyMediumStyle(colors.textSecondary),
                    ),
                    ListView.builder(
                      itemCount: defaultFilters.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => FilterTile(
                        index: index,
                        item: defaultFilters[index],
                        selected: false,
                        // context.watch<FilterCubit>().state.selectedIndex ==
                        //     index,
                        onTap: () {
                          defaultFilters[index].onTap;
                        },
                      ),
                    ),
                    AppComponents.mediumVerticalSpace(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).custom_filters,
                            style: AppConstants.bodyMediumStyle(
                                colors.textSecondary),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AddFilterDialog();
                              },
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(colors.primary),
                            overlayColor:
                                WidgetStatePropertyAll(colors.fillColor),
                            surfaceTintColor:
                                WidgetStatePropertyAll(colors.fillColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppConstants.kRadius - 4),
                              ),
                            ),
                          ),
                          label: Text(S.of(context).add_filter),
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                    AppComponents.smallVerticalSpace(),
                    ListView.builder(
                        itemCount: defaultFilters.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FilterTile(
                            index: index,
                            item: defaultFilters[index],
                            selected: false,
                            // context.watch<FilterCubit>().state.selectedIndex ==
                            //     index,
                            onTap: () {
                              defaultFilters[index].onTap;
                            },
                          );
                        })
                  ],
                ),
              ),
            );
          });
    },
  );
}

class AddFilterDialog extends StatelessWidget {
  const AddFilterDialog({super.key});

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
              const AddFilterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFilterForm extends StatefulWidget {
  const AddFilterForm({super.key});

  @override
  State<AddFilterForm> createState() => _AddFilterFormState();
}

class _AddFilterFormState extends State<AddFilterForm> {
  final _filterNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).filterName,
          style: AppConstants.filterStyle(colors.textPrimary),
        ),
        AppComponents.smallVerticalSpace(),
        CustomTextFormField(
          filled: true,
          fillColor: colors.fillColor,
          controller: _filterNameController,
          hintText: S.of(context).filterNamePlaceholder,
          // customInputStyle: AppConstants.filterStyle(colors.textPrimary),
          customBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            borderSide: BorderSide.none,
          ),
        ),
        AppComponents.smallVerticalSpace(),
        const PickColorGridView(),
        AppComponents.mediumVerticalSpace(),
        Text(
          S.of(context).preview,
          style: AppConstants.filterStyle(colors.textPrimary),
        ),
        Container(
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
                color: colors.filterColors[0],
                borderRadius: BorderRadius.circular(AppConstants.kRadius - 6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                _filterNameController.text.isEmpty
                    ? S.of(context).previewFilterName
                    : _filterNameController.text,
                style: AppConstants.bodySmallStyle(colors.textInverse),
              ),
            ),
          ),
        ),
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
                    onPressed:
                        _filterNameController.text.isEmpty ? null : () {},
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

class FilterTile extends StatelessWidget {
  final MenuItemModel item;
  final bool selected;
  final VoidCallback onTap;
  final int index;

  const FilterTile({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return ListTile(
      onTap: () {
        // context.read<FilterCubit>().switchSelection(index);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      selected: selected,
      selectedColor: colors.reverseBackgroundColor,
      selectedTileColor: colors.textInverse,
      leading: Icon(item.icon, color: colors.primary),
      title: Text(
        item.title,
        style: AppConstants.bodyMediumStyle(colors.textPrimary),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: colors.backgroundMuted,
          borderRadius: BorderRadius.circular(AppConstants.kRadius - 6),
          border: Border.all(color: colors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          item.count.toString(),
          style: AppConstants.bodyMediumStyle(colors.textPrimary),
        ),
      ),
    );
  }
}
