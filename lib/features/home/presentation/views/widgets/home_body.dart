import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';
import '../../../../../core/widgets/filter_and_change_view.dart';
import 'page_view_builder.dart';
import 'top_body_navi_builder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.homeContext,
  });
  final BuildContext homeContext;

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
          FilterAndChangeView(
            isInNotes: isInNotes,
            homeContext: homeContext,
          ),
          AppComponents.customDivider(15),
          PageViewBuilder(
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
