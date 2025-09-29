import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../note/presentation/view/note_view.dart';
import '../../../../task/presentation/view/task_view.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    List<Widget> homeBodyList = [
      const NoteView(),
      const TaskView(),
    ];
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: homeBodyList.length,
        onPageChanged: (index) {
          context.read<TopBodyNaviCubit>().changeBody(index);
        },
        itemBuilder: (context, index) {
          return homeBodyList[index];
        },
      ),
    );
  }
}
