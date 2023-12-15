import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         colorFilter: ColorFilter.mode(
      //             Colors.black.withOpacity(0.6), BlendMode.dstATop),
      //         image: const AssetImage("images/Intro.jpg"),
      //         fit: BoxFit.cover)),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Text(
          "Flutter Forecast",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
        )),
      ),
    );
  }
}
