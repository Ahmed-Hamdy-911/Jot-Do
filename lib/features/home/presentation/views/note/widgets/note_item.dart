import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import 'slidable_actions.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.color,
    required this.index,
  });
  final Color color;
  final int index;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var content = S.of(context).note_content;
    final dateTime = AppConstants.formatDateTime(DateTime.now());

    return Slidable(
      key: ValueKey(index),
      startActionPane: onDismissibleStartAction(context),
      endActionPane: onDismissibleEndAction(context),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
        highlightColor: color.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.all(18).copyWith(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    color.withValues(alpha: 0.9),
                    color.withValues(alpha: 0.7),
                    color.withValues(alpha: 0.5),
                    color.withValues(alpha: 0.3)
                  ])),
          child: screenWidth > 600
              ? NoteBody(
                  content: content,
                  dateTime: dateTime,
                  color: color,
                  titleFontSize: 22,
                  contentFontSize: 16,
                  showMoreFontSize: 14,
                  dateTimeFontSize: 13,
                )
              : NoteBody(
                  content: content,
                  dateTime: dateTime,
                  color: color,
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
    required this.content,
    required this.dateTime,
    required this.color,
    required this.titleFontSize,
    required this.contentFontSize,
    required this.dateTimeFontSize,
    required this.showMoreFontSize,
  });

  final String content;
  final String dateTime;
  final Color color;
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
              S.of(context).note_title,
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
                    text: AppConstants.getTruncatedText(text: content),
                    style: TextStyle(
                      fontSize: contentFontSize,
                      color: Colors.black45,
                      fontFamily: fontFamily,
                    ),
                  ),
                  if (content.length >
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              highlightColor: color.withValues(alpha: 0.3),
              splashColor: color.withValues(alpha: 0.3),
              child: Ink(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(
                  IconlyLight.heart,
                  size: 28,
                  color: color,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
