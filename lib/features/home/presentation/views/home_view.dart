import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../core/cubits/connectivity/connection_state.dart';
import '../cubits/bottom_sheet_cubit/bottom_sheet_cubit.dart';
import '../cubits/bottom_sheet_cubit/bottom_sheet_state.dart';
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

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    context.read<BottomSheetCubit>().setScaffoldKey(scaffoldKey);
    return BlocBuilder<BottomSheetCubit, BottomSheetState>(
      builder: (context, bsState) {
        final isSheetOpen = bsState.isOpen;

        return Scaffold(
          key: scaffoldKey,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomHomeAppBar(),
          ),
          body: const HomeBody(),
          bottomNavigationBar: isSheetOpen
              ? const SizedBox.shrink()
              : Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.backgroundScreen.withValues(alpha: 0.4),
                        colors.backgroundScreen.withValues(alpha: 0.8),
                        colors.backgroundScreen,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: CustomFloatingButton(
            currentPage: context.watch<TopBodyNaviCubit>().state,
          ),
        );
      },
    );
  }
}
