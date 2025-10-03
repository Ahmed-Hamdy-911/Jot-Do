import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../generated/l10n.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/widgets/components/loading_animation.dart';
import '../manager/cubit/splash_cubit.dart';

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

    final colors = SmartAppColor(context);
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: colors.backgroundScreen,
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).appName,
                        style: screenWidth >= 600
                            ? AppConstants.largeAppNameStyle(colors.textPrimary)
                            : AppConstants.mediumAppNameStyle(
                                colors.textPrimary),
                      ),
                      Text(
                        S.of(context).splashText2,
                        style: AppConstants.bodySmallStyle(
                          colors.textSecondary,
                        ),
                      ),
                      AppComponents.smallHorizontalSpace(),
                      const LoadingAnimation(
                        height: 120,
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
              AppComponents.mediumVerticalSpace(),
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
                        color: colors.textPrimary,
                        fontFamily: 'Kalam',
                      ),
                    ),
                    Text(S.of(context).splashText2,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: colors.textSecondary,
                        )),
                    AppComponents.largeVerticalSpace(),
                    const LoadingAnimation()
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
