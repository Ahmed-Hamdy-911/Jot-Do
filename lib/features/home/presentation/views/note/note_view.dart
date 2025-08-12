import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListViewBuilder();
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 17,
            itemBuilder: (context, index) => NoteItem(
              color: AppConstants.noteColors[index],
            ),
          ),
        ),
        const SmallSpace(),
      ],
    );
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    const String content =
        "Pariatur anim ex reprehenderit elit ipsum velit velit eu aute veniam occaecat. Pariatur anim ex reprehenderit elit ipsum velit velit eu aute veniam occaecat. Nisi amet qui velit sint voluptate occaecat veniam amet cillum aliqua in. Esse enim quis labore labore elit. Cupidatat aute est ex qui laboris anim quis eu dolore irure consequat. Anim aute eiusmod elit irure. Aute ullamco magna magna voluptate cillum cupidatat nulla exercitation adipisicing deserunt veniam reprehenderit ipsum.";
    final dateTime = AppConstants.formatDateTime(DateTime.now());

    return Container(
      margin: EdgeInsetsDirectional.only(top: 12),
      padding: EdgeInsets.all(18).copyWith(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                color.withOpacity(0.9),
                color.withOpacity(0.7),
                color.withOpacity(0.5),
                color.withOpacity(0.3)
              ])),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Title Of Your Note",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
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
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    if (content.length >
                        AppConstants.maxLengthOfDescNoteInHomeView)
                      TextSpan(
                        text: "  Show more",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.blue,
                          fontFamily: 'Tajawal',
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
                    fontFamily: 'Tajawal',
                  ),
                ),
              )
            ],
          ),
          PositionedDirectional(
            top: 0,
            end: 0,
            child: CircleAvatar(
              radius: screenWidth * 0.04,
              backgroundColor: color.withOpacity(0.6),
              child: Icon(
                IconlyLight.heart,
                size: screenWidth * 0.07,
              ),
            ),
          )
        ],
      ),
    );
  }
}
