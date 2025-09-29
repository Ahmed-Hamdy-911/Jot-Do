import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';
import 'page_view_builder.dart';
import 'top_body_navi_builder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);
    var controller = TextEditingController();
    bool isInNotes = context.watch<TopBodyNaviCubit>().state == 0;
    var hintText =
        isInNotes ? S.of(context).search_note : S.of(context).search_task;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          TopBodyNavigation(
            pageController: _pageController,
          ),
          CustomSearchField(controller: controller, hintText: hintText),
          PageViewBuilder(
              pageController: _pageController,
              ),
        ],
      ),
    );
  }
}
