import 'package:covid19_tracker/constants/utils.dart';
import 'package:covid19_tracker/widgets/reusable_row.dart';
import 'package:flutter/material.dart';

class CountriesDetailScreen extends StatefulWidget {
  final String image, name;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      crtical,
      todayRecovered,
      test;

  const CountriesDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.crtical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountriesDetailScreen> createState() => _CountriesDetailScreenState();
}

class _CountriesDetailScreenState extends State<CountriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: bgClr,
        iconTheme: IconThemeData(color: whiteClr, size: 24),
        title: Text(widget.name, style: TextStyle(color: whiteClr)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Card(
                    color: cardClr,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                      child: Column(
                        children: [
                          ReusableRow(
                            title: "Cases",
                            value: widget.totalCases.toString(),
                          ),
                          ReusableRow(
                            title: "Active",
                            value: widget.active.toString(),
                          ),
                          ReusableRow(
                            title: "Critical",
                            value: widget.crtical.toString(),
                          ),
                          ReusableRow(
                            title: "Tests",
                            value: widget.test.toString(),
                          ),
                          ReusableRow(
                            title: "Recovered Today",
                            value: widget.todayRecovered.toString(),
                          ),
                          ReusableRow(
                            title: "Total Recovered",
                            value: widget.totalRecovered.toString(),
                          ),
                          ReusableRow(
                            title: "Total Deaths",
                            value: widget.totalDeaths.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
