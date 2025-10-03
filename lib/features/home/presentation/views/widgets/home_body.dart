import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/custom_fields/custom_search_field.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';
import 'page_view_builder.dart';
import 'top_body_navi_builder.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isInNotes = context.watch<TopBodyNaviCubit>().state == 0;
    var hintText =
        isInNotes ? S.of(context).search_note : S.of(context).search_task;
    final showSearchField =
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          TopBodyNavigation(pageController: widget.pageController),
          if (showSearchField)
            CustomSearchField(
                controller: _searchController, hintText: hintText),
          if (!showSearchField) AppComponents.smallVerticalSpace(),
          PageViewBuilder(pageController: widget.pageController),
        ],
      ),
    );
  }
}
