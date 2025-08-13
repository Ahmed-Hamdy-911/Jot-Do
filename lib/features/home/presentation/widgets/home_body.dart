import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../views/note/note_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TabBarView(
        controller: tabController,
        children: [
          NoteView(),
          Center(
            child: Text(
              S.of(context).your_tasks,
            ),
          ),
        ],
      ),
    );
  }
}
