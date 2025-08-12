import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/features/home/presentation/views/note/note_view.dart';
import 'package:jot_do/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            tabController: _tabController,
          ),
        ),
        body: HomeBody(
          tabController: _tabController,
        ),
      ),
    );
  }
}

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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: TabBar(
        dividerColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        unselectedLabelColor: Colors.grey[800],
        labelColor: AppConstants.colorScheme,
        indicatorColor: AppConstants.colorScheme.shade800,
        tabs: [
          Tab(
            text: S.of(context).your_notes,
          ),
          Tab(
            text: S.of(context).your_tasks,
          ),
        ],
      ),
    );
  }
}
