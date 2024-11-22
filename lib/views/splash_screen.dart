import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify_clone/views/main_screen.dart';
import 'package:flame_audio/flame_audio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _playSplashSound();
  }

  Future<void> _playSplashSound() async {
    try {
      await FlameAudio.play('splashsound.mp3', volume: 4.0);
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/animation/spotifysplash.json'),
      ),
      nextScreen: MainScreen(),
      duration: 3000,
      splashIconSize: 300,
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    FlameAudio.bgm.dispose(); // Clean up audio resources
    super.dispose();
  }
}