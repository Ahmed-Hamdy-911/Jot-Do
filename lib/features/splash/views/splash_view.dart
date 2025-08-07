import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
              Image.asset(
                'assets/icons/jot&do_icon.png',
                width: width * 0.4,
              ),
              SizedBox(height: height * 0.02),
              Text(
                S.of(context).appName,
                style: TextStyle(
                  fontSize: width * 0.104,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(S.of(context).splashText2,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.white,
                    )),
              ),
            ],
          )),
    );
  }
}
