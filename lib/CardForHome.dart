import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class macrosCard extends StatelessWidget {
  macrosCard({super.key});
  double goalCal = 2000;
  double dailyCal = 1000;
  double burnedCal = 800;

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
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(PieChartData(
                          centerSpaceRadius: 50,
                          centerSpaceColor: Colors.white,
                          sections: [
                            PieChartSectionData(
                                value: goalCal - dailyCal,
                                title: " ",
                                radius: 10,
                                color: Colors.blue),
                            PieChartSectionData(
                                value: dailyCal,
                                radius: 10,
                                title: "${dailyCal / goalCal * 100}%",
                                titleStyle: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                                color: Colors.orange),
                          ])),
                    ),
                  ],
                ),
              ],
            ),
            /*const Divider(
              thickness: 1,
            ),
            const Center(
                /*child: Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Text("Food"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Calories"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Carbs"),
                  SizedBox(
                    width: 60,
                  ),
                  Text("Protein"),
                  SizedBox(
                    width: 80,
                  ),
                  Text("Fat"),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),*/
                )*/
          ],
        ),
      ),
    );
  }
}
