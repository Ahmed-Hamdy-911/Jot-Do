import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/filter_title_and_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../../../filters/presentation/cubits/filter/filter_state.dart';
import '../../../data/models/note_model.dart';
import '../../cubits/add/add_note_cubit.dart';
import '../../cubits/add/add_note_state.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  final InputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.kRadius),
    borderSide: BorderSide.none,
  );

  final bool filled = true;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    final TextStyle customInputStyle = TextStyle(
      color: colors.textPrimary,
      fontSize: 18,
    );
    final isWideScreen = screenWidth >= 600;
    var dateTime = DateTime.now().toIso8601String();
    return BlocConsumer<AddNoteCubit, AddNoteStates>(
      listener: (context, state) {
        if (state is AddNoteSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: S.of(context).note_title,
                controller: _titleController,
                customBorder: customBorder,
                maxLines: isWideScreen ? 3 : 2,
                customInputStyle: customInputStyle,
                filled: filled,
                fillColor: colors.fillColor,
              ),
              AppComponents.customDivider(15),
              CustomTextFormField(
                hintText: S.of(context).note_content,
                validator: (p0) {
                  return null;
                },
                controller: _contentController,
                customBorder: customBorder,
                maxLines: isWideScreen
                    ? (screenHeight * 0.58 / 20).floor()
                    : (screenWidth * 0.8 / 15).floor(),
                filled: filled,
                fillColor: colors.fillColor,
                customInputStyle: customInputStyle.copyWith(fontSize: 15),
              ),
              const CustomFiltersView(),
              CustomMaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AddNoteCubit>().addNote(
                          NoteModel(
                            title: _titleController.text,
                            content: _contentController.text,
                            createdAt: dateTime,
                            filterIds: context
                                .read<FilterCubit>()
                                .state
                                .selectedFilterId,
                          ),
                        );
                    log("Note Added: Title='${_titleController.text}', Content='${_contentController.text}', CreatedAt='$dateTime', FilterId='${context.read<FilterCubit>().state.selectedFilterId}'");
                  }
                },
                text: S.of(context).save_note,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomFiltersView extends StatefulWidget {
  const CustomFiltersView({
    super.key,
  });

  @override
  State<CustomFiltersView> createState() => _CustomFiltersViewState();
}

class _CustomFiltersViewState extends State<CustomFiltersView> {
  initState() {
    context.read<FilterCubit>().loadFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        AppComponents.customDivider(15),
        AppComponents.smallVerticalSpace(),
        CustomFilterTitleAndButton(
            colors: colors, isInBottomSheet: false, parentContext: context),
        BlocBuilder<FilterCubit, FilterState>(
          builder: (context, state) {
            final customFilters = [...state.filters]
              ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
            return Container(
              height: 50.h,
              width: screenWidth,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: colors.fillColor,
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
              ),
              child: ListView.builder(
                itemCount: customFilters.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final filter = customFilters[index];
                  final isSelected = filter.id == state.selectedFilterId;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Row(
                        children: [
                          Text(
                            filter.name,
                            style:
                                AppConstants.bodySmallStyle(colors.textPrimary),
                          ),
                          AppComponents.largeHorizontalSpace(),
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(filter.color),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        context.read<FilterCubit>().selectFilter(
                              isSelected ? null : filter.id,
                            );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
        AppComponents.smallVerticalSpace(),
      ],
    );
  }
}
