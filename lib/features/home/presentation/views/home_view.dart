import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../core/cubits/connectivity/connection_state.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../generated/l10n.dart';
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
        if (state is ConnectionTimeOut) {
          CustomSnackBar.showSnackBar(
            state.message,
            context,
            MessageType.info,
          );
        }
        if (state is ConnectionDisconnected) {
          CustomSnackBar.showSnackBar(
            S.of(context).noInternet,
            context,
            MessageType.warning,
          );
        } else if (state is ConnectionReconnected) {
          CustomSnackBar.showSnackBar(
            S.of(context).connectedInternet,
            context,
            MessageType.success,
          );
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TopBodyNaviCubit(),
          ),
        ],
        child: const HomeScaffold(),
      ),
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Scaffold(
      extendBody: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHomeAppBar(
            // notesLength: context.watch<NotesCubit>().notesList.length,
            ),
      ),
      body: HomeBody(
        homeContext: context,
      ),
      bottomNavigationBar: Container(
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
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingButton(
        currentPage: context.watch<TopBodyNaviCubit>().state,
      ),
    );
  }
}
