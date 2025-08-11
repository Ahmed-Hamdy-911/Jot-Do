import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jot_do/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Center(
        child: Text(S.of(context).your_notes),
      ),
      Center(
        child: Text(S.of(context).your_tasks),
      ),
    ]);
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: S.of(context).your_notes),
          Tab(text: S.of(context).your_notes),
        ],
      ),
    );
  }
}
