import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../data/models/note_model.dart';
import '../../../manager/cubits/Note/NotesCubits/notes_cubit.dart';
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
    return Slidable(
      key: ValueKey(index),
      startActionPane: onDismissibleStartAction(context, note: note),
      endActionPane: onDismissibleEndAction(context, note: note),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.noteDetails);
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
                  colors: [
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
                    text: AppConstants.getTruncatedText(text: note.content),
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
                note.createdAt,
                style: TextStyle(
                  color: Colors.grey[700],
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
                note: note,
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
                  note: note,
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

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.note,
    this.onTap,
    required this.icon,
  });

  final NoteModel note;
  final void Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        highlightColor: Color(note.color).withValues(alpha: 0.3),
        splashColor: Color(note.color).withValues(alpha: 0.3),
        child: Ink(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Color(note.color),
          ),
        ),
      ),
    );
  }
}
