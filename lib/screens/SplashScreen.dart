
import 'package:assignment/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 94, 162, 240),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: AnimatedTextKit(
              onFinished: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) =>const  HomeScreen()));
              },
              animatedTexts: [
                TypewriterAnimatedText(
                  'Hi...',
                  cursor: ".",
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  speed: const Duration(milliseconds: 150),
                ),
                TypewriterAnimatedText('I Task Manager',
                    textAlign: TextAlign.center,
                    curve: Curves.ease,
                    textStyle: const TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 110),
                    cursor: "!"),
                TypewriterAnimatedText(
                  'Lets Manage your Task!',
                  textAlign: TextAlign.center,
                  curve: Curves.ease,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  speed: const Duration(milliseconds: 100),
                  cursor: "!",
                ),
                
              ],
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          )
        ],
      ),
    );
  }
}
