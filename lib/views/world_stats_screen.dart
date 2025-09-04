import 'package:covid19_tracker/methods/stats_services.dart';
import 'package:covid19_tracker/models/world_stats_model.dart';
import 'package:covid19_tracker/constants/utils.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:covid19_tracker/widgets/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    StatsServices statsServices = StatsServices();
    final screenH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: bgClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(
            children: [
              FutureBuilder(
                future: statsServices.fetchWorldStats(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: whiteClr,
                        size: 50,
                        controller: animationController,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: screenH * 0.05),
                        MyPieChart(
                          total: double.parse(snapshot.data!.cases!.toString()),
                          recovered: double.parse(
                            snapshot.data!.recovered!.toString(),
                          ),
                          death: double.parse(
                            snapshot.data!.deaths!.toString(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenH * 0.04,
                          ),
                          child: Card(
                            color: cardClr,
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases!.toString(),
                                ),
                                ReusableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths!.toString(),
                                ),
                                ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered!.toString(),
                                ),
                                ReusableRow(
                                  title: "Active",
                                  value: snapshot.data!.active!.toString(),
                                ),
                                ReusableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical!.toString(),
                                ),
                                ReusableRow(
                                  title: "Deaths Today",
                                  value: snapshot.data!.todayDeaths!.toString(),
                                ),
                                ReusableRow(
                                  title: "Recovered Today",
                                  value:
                                      snapshot.data!.todayRecovered!.toString(),
                                ),
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
