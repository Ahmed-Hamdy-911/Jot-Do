import 'package:flutter/material.dart';

Widget buildOnBoardingPage(
  BuildContext context, {
  required String title,
  required String description,
  required String image,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  double titleFontSize;
  double descriptionFontSize;

  if (screenWidth < 500) {
    // Mobile
    titleFontSize = screenWidth * 0.05;
    descriptionFontSize = screenWidth * 0.04;
  } else if (screenWidth < 1024) {
    // Tablet
    titleFontSize = 32;
    descriptionFontSize = 20;
  } else {
    // Desktop/Web
    titleFontSize = 40;
    descriptionFontSize = 24;
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 500) {
          // 📌 Desktop / Wide tablet → Row layout
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 86, 1, 101),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: descriptionFontSize,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // 📌 Mobile → Column layout
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height:
                    screenWidth < 500 ? screenWidth * 0.8 : screenWidth * 0.6,
                fit: BoxFit.contain,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 86, 1, 101),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
      },
    ),
  );
}

class BuildResponseBoardingImage extends StatelessWidget {
  const BuildResponseBoardingImage({
    super.key,
    required this.image,
    required this.height,
  });

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
