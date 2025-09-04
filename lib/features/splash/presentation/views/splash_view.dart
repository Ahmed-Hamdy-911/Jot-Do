import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets/app_assets.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../generated/l10n.dart';
import 'package:page_transition/page_transition.dart';
import '../manager/SplashCubit/splash_cubit.dart';
import '../../../../core/constants/colors/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Scaffold(
        body: SplashBody(),
      ),
    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Widget nextScreen() {
      return context.read<SplashCubit>().checkNextScreen();
    }

    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        center: Alignment.center,
        radius: 1.4,
        colors: AppColor.splashColorsList,
      )),
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.25,
                  child: AnimatedSplashScreen(
                    nextScreen: nextScreen(),
                    backgroundColor: Colors.transparent,
                    curve: Curves.bounceOut,
                    splashTransition: SplashTransition.sizeTransition,
                    pageTransitionType: PageTransitionType.fade,
                    duration: 2000,
                    splashIconSize: screenWidth * 0.25,
                    splash: AnimatedCrossFade(
                      crossFadeState: CrossFadeState.showFirst,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 1000),
                      firstChild: Image.asset(
                        AppAssets.splash,
                        fit: BoxFit.contain,
                      ),
                      secondChild: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).appName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        S.of(context).splashText2,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenWidth * 0.4,
                child: AnimatedSplashScreen(
                  nextScreen: nextScreen(),
                  backgroundColor: Colors.transparent,
                  curve: Curves.bounceOut,
                  splashTransition: SplashTransition.sizeTransition,
                  pageTransitionType: PageTransitionType.fade,
                  duration: 2000,
                  splashIconSize: screenWidth,
                  splash: AnimatedCrossFade(
                    crossFadeState: CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 1000),
                    firstChild: Image.asset(
                      AppAssets.splash,
                      width: screenWidth,
                    ),
                    secondChild: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              const MediumSpace(),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    Text(
                      S.of(context).appName,
                      style: TextStyle(
                        fontSize: screenWidth * 0.104,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(S.of(context).splashText2,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
