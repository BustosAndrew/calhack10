import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class macrosCard extends StatelessWidget {
  const macrosCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(100))),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Column(
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
                                Text("1127 kcals"),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text("Burned"),
                            Row(
                              children: [
                                Text("1127 kcals"),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(
                          PieChartData(centerSpaceRadius: 50, sections: [
                        PieChartSectionData(
                            value: 10,
                            title: " ",
                            radius: 10,
                            color: Colors.blue),
                        PieChartSectionData(
                            value: 1,
                            radius: 10,
                            title: "Cals eaten: 200",
                            titleStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            color: Colors.orange),
                      ])),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
