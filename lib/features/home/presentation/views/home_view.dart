import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/bottom_navi/bottom_navi_cubit_cubit.dart';
import 'settings/settings_view.dart';
import '../widgets/home_body.dart';

import '../../../../core/constants/app_constants.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_floating_button.dart';
import '../widgets/custom_home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNaviCubit(),
      child: const HomeScaffold(),
    );
  }
}

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      AppConstants.homeBodyIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeBody(tabController: _tabController),
      const SettingsView(),
    ];
    var bottomCubit = BlocProvider.of<BottomNaviCubit>(context);
    bool isHome = context.watch<BottomNaviCubit>().state == 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: isHome
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomHomeAppBar(
                  tabController: _tabController,
                ),
              )
            : null,
        body: screens[bottomCubit.currentIndex],
        bottomNavigationBar: const CustomBottomNaviAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const CustomFloatingButton(),
      ),
    );
  }
}
