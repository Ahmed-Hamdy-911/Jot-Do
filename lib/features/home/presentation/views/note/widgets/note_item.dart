import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/services/format_service.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../core/widgets/custom_icon.dart';
import '../../../../data/models/note_model.dart';
import '../../../cubits/notes/get/notes_cubit.dart';
import 'slidable_actions.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.index,
    required this.note,
  });

  final int index;
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final color = note.color;
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;

    return Slidable(
      key: ValueKey(index),
      startActionPane: onDismissibleStartAction(context, note: note),
      endActionPane: onDismissibleEndAction(context, note: note),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.noteDetails,
            arguments: note,
          );
        },
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
        highlightColor: Color(color).withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.all(18).copyWith(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: darkMode
                      ? [
                          Color(color),
                          Color(color),
                        ]
                      : [
                          Color(color).withValues(alpha: 0.9),
                          Color(color).withValues(alpha: 0.7),
                          Color(color).withValues(alpha: 0.5),
                          Color(color).withValues(alpha: 0.3)
                        ])),
          child: screenWidth > 600
              ? NoteBody(
                  note: note,
                  titleFontSize: 22,
                  contentFontSize: 16,
                  showMoreFontSize: 14,
                  dateTimeFontSize: 13,
                )
              : NoteBody(
                  note: note,
                  titleFontSize: 20,
                  contentFontSize: 14,
                  showMoreFontSize: 12,
                  dateTimeFontSize: 11,
                ),
        ),
      ),
    );
  }
}

class NoteBody extends StatelessWidget {
  const NoteBody({
    super.key,
    required this.note,
    required this.titleFontSize,
    required this.contentFontSize,
    required this.dateTimeFontSize,
    required this.showMoreFontSize,
  });

  final NoteModel note;
  final double titleFontSize;
  final double contentFontSize;
  final double showMoreFontSize;
  final double dateTimeFontSize;

  @override
  Widget build(BuildContext context) {
    const fontFamily = "Tajawal";
    final dateTime = FormatService.formatDateTime(note.createdAt);
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamily,
                fontSize: titleFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const MediumSpace(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: FormatService.getTruncatedText(text: note.content),
                    style: TextStyle(
                      fontSize: contentFontSize,
                      color: Colors.black45,
                      fontFamily: fontFamily,
                    ),
                  ),
                  if (note.content.length >
                      AppConstants.maxLengthOfContentNoteInHomeView)
                    TextSpan(
                      text: "  Show more",
                      style: TextStyle(
                        fontSize: showMoreFontSize,
                        color: Colors.blue,
                        fontFamily: fontFamily,
                      ),
                    ),
                ],
              ),
            ),
            const SmallSpace(),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Text(
                dateTime,
                style: TextStyle(
                  color: darkMode ? AppColor.white70 : AppColor.grey600,
                  fontSize: dateTimeFontSize,
                  fontFamily: fontFamily,
                ),
              ),
            ),
          ],
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomIcon(
                noteColor: Color(note.color),
                icon: note.isFavorite ? IconlyBold.heart : IconlyLight.heart,
                onTap: () {
                  context.read<NotesCubit>().toggleFavoriteNote(note.id!, note);
                },
              ),
              const SizedBox(
                width: 8,
              ),
              if (note.isPinned)
                CustomIcon(
                  noteColor: Color(note.color),
                  icon: Icons.push_pin,
                  onTap: () {
                    context.read<NotesCubit>().togglePinNote(note.id!, note);
                  },
                ),
            ],
          ),
        )
      ],
    );
  }
}
