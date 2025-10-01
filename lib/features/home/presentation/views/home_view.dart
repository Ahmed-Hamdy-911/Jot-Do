import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../core/cubits/connectivity/connection_state.dart';
import '../cubits/bottom_sheet_cubit/bottom_sheet_cubit.dart';
import '../cubits/top_body_navi/top_body_navi_cubit_.dart';
import 'widgets/home_body.dart';

import 'widgets/custom_floating_button.dart';
import 'widgets/custom_home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionCubit, ConnectionStates>(
      listener: (context, state) {
        // if (state is ConnectionTimeOut) {
        //   CustomSnackBar.showSnackBar(
        //     state.message,
        //     context,
        //     MessageType.info,
        //   );
        // }
        // if (state is ConnectionDisconnected) {
        //   CustomSnackBar.showSnackBar(
        //     S.of(context).noInternet,
        //     context,
        //     MessageType.warning,
        //   );
        // } else if (state is ConnectionReconnected) {
        //   CustomSnackBar.showSnackBar(
        //     S.of(context).connectedInternet,
        //     context,
        //     MessageType.success,
        //   );
        // }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TopBodyNaviCubit(),
          ),
          BlocProvider(
            create: (context) => BottomSheetCubit(),
          ),
        ],
        child: const HomeScaffold(),
      ),
    );
  }
}

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  late final PageController _pageController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    context.read<BottomSheetCubit>().setScaffoldKey(scaffoldKey);
    final showBottomNavBar = (Platform.isAndroid || Platform.isIOS);
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHomeAppBar(),
      ),
      body: HomeBody(pageController: _pageController),
      bottomNavigationBar: showBottomNavBar
          ? Container(
              height: 30.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.backgroundScreen.withValues(alpha: 0.01),
                    colors.backgroundScreen.withValues(alpha: 0.3),
                    colors.backgroundScreen.withValues(alpha: 0.6),
                    colors.backgroundScreen,
                  ],
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingButton(
        currentPage: context.watch<TopBodyNaviCubit>().state,
      ),
    );
  }
}
