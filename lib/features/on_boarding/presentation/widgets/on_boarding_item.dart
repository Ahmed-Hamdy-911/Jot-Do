 import 'package:flutter/material.dart';

Widget buildOnBoardingPage(BuildContext context,
      {required String title,
      required String description,
      required String image}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 86, 1, 101),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
