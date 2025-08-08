import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';
import 'package:page_transition/page_transition.dart';

import '../../../on_boarding/presentation/views/on_boarding_view.dart';

class SplashView extends StatelessWidget {
  final Widget? startWidget;
  const SplashView({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.3,
          colors: [
            Color(0xffa724ec),
            Color(0xff9d33ef),
            Color(0xff8c4af4),
            Color(0xff8059f8),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: width * 0.4,
              child: AnimatedSplashScreen(
                nextScreen: const OnBoardingView(),
                backgroundColor: Colors.transparent,
                curve: Curves.bounceOut,
                splashTransition: SplashTransition.sizeTransition,
                pageTransitionType: PageTransitionType.fade,
                duration: 3000,
                splashIconSize: width,
                splash: AnimatedCrossFade(
                  crossFadeState: CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 1000),
                  firstChild: Image.asset(
                    'assets/icons/jot&do_icon.png',
                    width: width * 0.4,
                  ),
                  secondChild: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
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
                      fontSize: width * 0.104,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(S.of(context).splashText2,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
