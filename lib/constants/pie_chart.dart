import 'package:covid19_tracker/constants/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: PieChart(
            curve: Curves.easeInOutQuint,
            duration: Duration(milliseconds: 500),
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 40,
                  title: "40%",
                  titleStyle: TextStyle(
                    color: whiteClr,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: pieClrList[0],
                  radius: 100,
                ),
                PieChartSectionData(
                  value: 30,
                  title: "30%",
                  titleStyle: TextStyle(
                    color: whiteClr,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: pieClrList[1],
                  radius: 100,
                ),
                PieChartSectionData(
                  value: 30,
                  title: "30%",
                  titleStyle: TextStyle(
                    color: whiteClr,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: pieClrList[2],
                  radius: 100,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLegendItem(pieClrList[0], "Total"),
            buildLegendItem(pieClrList[1], "Recovered"),
            buildLegendItem(pieClrList[2], "Deaths"),
          ],
        ),
      ],
    );
  }
}

Widget buildLegendItem(Color color, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}
