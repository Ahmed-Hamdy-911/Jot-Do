import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var content = S.of(context).note_content;
    final dateTime = AppConstants.formatDateTime(DateTime.now());
    const fontFamily = "Tajawal";
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: 12,
      ),
      padding: EdgeInsets.all(18).copyWith(bottom: 10),
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
      child: Slidable(
        child: Stack(
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
                    fontSize: screenWidth * 0.06,
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
                          fontSize: screenWidth * 0.043,
                          color: Colors.black45,
                          fontFamily: fontFamily,
                        ),
                      ),
                      if (content.length >
                          AppConstants.maxLengthOfDescNoteInHomeView)
                        TextSpan(
                          text: "  Show more",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
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
                      fontSize: screenWidth * 0.033,
                      fontFamily: fontFamily,
                    ),
                  ),
                )
              ],
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: screenWidth * 0.04,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: Icon(
                    IconlyLight.heart,
                    size: screenWidth * 0.07,
                    color: color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
