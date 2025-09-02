import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/widgets/custom_material_button.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../core/widgets/custom_text_form.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';
import '../../../manager/cubits/Note/AddNote/add_note_cubit.dart';
import '../../../manager/cubits/Note/AddNote/add_note_state.dart';
import '../../../manager/cubits/PickColor/pick_color_cubit.dart';
import '../../../widgets/pick_color_grid_view.dart';

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
  final TextStyle customInputStyle = const TextStyle(
    color: Colors.black,
    fontSize: 19,
  );
  final bool filled = true;
  final Color fillColor = Colors.grey.withValues(alpha: 0.1);

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    var selectedColor = context.watch<PickColorCubit>().state.selectedColor;
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
                fillColor: fillColor,
              ),
              customDivider(),
              CustomTextFormField(
                hintText: S.of(context).note_content,
                validator: (p0) {
                  return null;
                },
                controller: _contentController,
                customBorder: customBorder,
                maxLines: isWideScreen ? 12 : 16,
                filled: filled,
                fillColor: fillColor,
                customInputStyle: customInputStyle.copyWith(fontSize: 15),
              ),
              customDivider(),
              const PickColorGridView(),
              customDivider(),
              const SmallSpace(),
              CustomMaterialButton(
                color: selectedColor,
                isLoading: state is AddNoteLoadingState,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AddNoteCubit>().addNote(
                          NoteModel(
                            title: _titleController.text,
                            content: _contentController.text,
                            createdAt: dateTime,
                            color: selectedColor.value,
                          ),
                        );
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

  Widget customDivider() => const Divider(
        height: 15,
      );
}
