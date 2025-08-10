import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';
import 'package:jot_do/generated/l10n.dart';
import 'package:page_transition/page_transition.dart';

import '../../../on_boarding/presentation/views/on_boarding_view.dart';

class SplashView extends StatelessWidget {
  final Widget? startWidget;
  const SplashView({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.3,
          colors: AppConstants.splashColorsList,
        )),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: AnimatedSplashScreen(
                        nextScreen: const OnBoardingView(),
                        backgroundColor: Colors.transparent,
                        curve: Curves.bounceOut,
                        splashTransition: SplashTransition.sizeTransition,
                        pageTransitionType: PageTransitionType.fade,
                        duration: 3000,
                        splashIconSize: screenWidth,
                        splash: AnimatedCrossFade(
                          crossFadeState: CrossFadeState.showFirst,
                          alignment: AlignmentDirectional.center,
                          duration: Duration(milliseconds: 1000),
                          firstChild: Image.asset(
                            AppConstants.imageSplashPath,
                            width: screenWidth * 0.6,
                          ),
                          secondChild: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TweenAnimationBuilder<double>(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                    nextScreen: const OnBoardingView(),
                    backgroundColor: Colors.transparent,
                    curve: Curves.bounceOut,
                    splashTransition: SplashTransition.sizeTransition,
                    pageTransitionType: PageTransitionType.fade,
                    duration: 3000,
                    splashIconSize: screenWidth,
                    splash: AnimatedCrossFade(
                      crossFadeState: CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 1000),
                      firstChild: Image.asset(
                        AppConstants.imageSplashPath,
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
      ),
    );
  }
}
