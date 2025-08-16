import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/routing/app_routes.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';
import 'package:jot_do/generated/l10n.dart';

class SplashView extends StatefulWidget {
  final Widget? startWidget;
  const SplashView({super.key, this.startWidget});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _showFirst = true;
  @override
  void initState() {
    super.initState();
    logoChangeAnimation();
    naviToNextWidget();
  }

  Future<void> naviToNextWidget() {
    return Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.onBoarding, (route) => false);
    });
  }

  Future<void> logoChangeAnimation() {
    return Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showFirst = false;
        });
      }
    });
  }

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
          radius: 1.4,
          colors: AppConstants.splashColorsList,
        )),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedCrossFade(
                    crossFadeState: _showFirst
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 3000),
                    firstChild: Image.asset(
                      AppConstants.imageSplashPath,
                      fit: BoxFit.contain,
                      width: screenWidth * 0.25,
                    ),
                    secondChild: Container(
                      color: Colors.transparent,
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
                AnimatedCrossFade(
                  crossFadeState: _showFirst
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 3000),
                  firstChild: Image.asset(
                    AppConstants.imageSplashPath,
                    height: screenWidth * 0.4,
                    width: screenWidth,
                  ),
                  secondChild: Container(
                    color: Colors.transparent,
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
