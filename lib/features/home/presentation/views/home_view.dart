import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/features/home/presentation/manager/cubits/BottomNaviCubit/bottom_navi_cubit_cubit.dart';
import 'package:jot_do/features/home/presentation/widgets/home_body.dart';
import 'package:jot_do/generated/l10n.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => BottomNaviCubit(),
      ),
    ], child: HomeScaffold());
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeBody(tabController: _tabController),
      Container(
        child: Center(child: Text(S.of(context).settings)),
      ),
    ];
    var bottomCubit = BlocProvider.of<BottomNaviCubit>(context);
    return BlocBuilder<BottomNaviCubit, int>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: context.watch<BottomNaviCubit>().state == 0
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: CustomAppBar(
                      tabController: _tabController,
                    ),
                  )
                : AppBar(),
            body: screens[bottomCubit.currentIndex],
            bottomNavigationBar: CustomBottomNaviAppBar(),
          ),
        );
      },
    );
  }
}
