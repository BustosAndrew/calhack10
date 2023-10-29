import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MacrosCard extends StatelessWidget {
  final double goalCal;
  final double dailyCal;
  final double burnedCal;

  MacrosCard(
      {Key? key,
      this.goalCal = 2000,
      this.dailyCal = 1000,
      this.burnedCal = 800})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(/*topRight: Radius.circular(100)*/)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            Text("Eaten"),
                            Row(
                              children: [
                                Text(
                                  "${dailyCal.toStringAsFixed(0)} kcals",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Goal"),
                            Row(
                              children: [
                                Text(
                                  '${goalCal.toStringAsFixed(0)} kcals',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Burned"),
                            Row(
                              children: [
                                Text(
                                  "${burnedCal.toStringAsFixed(0)} kcals",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                                centerSpaceRadius: 50,
                                centerSpaceColor: Colors.white,
                                sections: [
                                  PieChartSectionData(
                                      value: goalCal - dailyCal,
                                      title:
                                          " ", // Keep this empty if you don't want a label
                                      radius: 10,
                                      color: Colors.blue),
                                  PieChartSectionData(
                                      value: dailyCal,
                                      radius: 10,
                                      title:
                                          "", // Remove the percentage title here
                                      color: Colors.orange),
                                ]),
                          ),
                          // Overlay the remaining calories in the center
                          Center(
                            child: Text(
                              "${(goalCal - dailyCal).toStringAsFixed(0)} Cals",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
