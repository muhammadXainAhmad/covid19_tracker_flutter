import 'package:covid19_tracker/constants/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  final double total, recovered, death;
  const MyPieChart({
    super.key,
    required this.total,
    required this.recovered,
    required this.death,
  });

  @override
  Widget build(BuildContext context) {
    final double sum = total + recovered + death;
    String formatPercent(double value) {
      if (sum == 0) return "0%";
      return "${((value / sum) * 100).toStringAsFixed(1)}%";
    }

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
                  value: total,
                  title: formatPercent(total),
                  titleStyle: TextStyle(
                    color: whiteClr,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: pieClrList[0],
                  radius: 100,
                ),
                PieChartSectionData(
                  value: recovered,
                  title: formatPercent(recovered),
                  titleStyle: TextStyle(
                    color: whiteClr,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: pieClrList[1],
                  radius: 100,
                ),
                PieChartSectionData(
                  value: death,
                  title: formatPercent(death),
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
        Text(title, style: TextStyle(fontSize: 14, color: whiteClr)),
      ],
    ),
  );
}
