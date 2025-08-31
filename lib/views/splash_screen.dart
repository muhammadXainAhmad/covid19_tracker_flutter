import 'dart:async';
import 'dart:math' as math;
import 'package:covid19_tracker/constants/utils.dart';
import 'package:covid19_tracker/views/world_stats_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorldStatsScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screenW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: bgClr,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                child: SizedBox(
                  width: screenW * 0.5,
                  child: const Center(
                    child: Image(image: AssetImage("assets/virus.png")),
                  ),
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animationController.value * 2 * math.pi,
                    child: child,
                  );
                },
              ),
              SizedBox(height: screenH * 0.1),
              Text(
                "COVID-19\nTRACKER APP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteClr,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
