import 'package:covid19_tracker/constants/pie_chart.dart';
import 'package:covid19_tracker/constants/reusable_row.dart';
import 'package:covid19_tracker/constants/utils.dart';
import 'package:flutter/material.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(
            children: [
              const MyPieChart(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenH * 0.04),
                child: const Card(
                  child: Column(
                    children: [
                      ReusableRow(title: "Total", value: "200"),
                      ReusableRow(title: "Total", value: "200"),
                      ReusableRow(title: "Total", value: "200"),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: successClr,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Track Countries",
                  style: TextStyle(color: whiteClr, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
