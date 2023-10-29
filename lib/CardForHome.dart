import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

Stream<Map<String, dynamic>> fetchUserDataStream(String userId) {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  // Listen to changes in user data
  Stream<DocumentSnapshot> userStream = userRef.snapshots();

  // Listen to changes in the dailyMacros collection
  Stream<QuerySnapshot> dailyMacrosStream =
      userRef.collection('dailyMacros').limit(1).snapshots();

  return Rx.combineLatest2(userStream, dailyMacrosStream,
      (userSnap, dailyMacrosSnap) {
    Map<String, dynamic> userData = userSnap.data() as Map<String, dynamic>;
    double goalCal = userData['goalcals']?.toDouble() ?? 2000.0;

    double dailyCal = 0.0;
    if (dailyMacrosSnap.docs.isNotEmpty) {
      Map<String, dynamic> dailyMacrosData =
          dailyMacrosSnap.docs.first.data() as Map<String, dynamic>;
      dailyCal = dailyMacrosData['calories']?.toDouble() ?? 0.0;
    }

    return {'goalcals': goalCal, 'calories': dailyCal};
  });
}

class MacrosCard extends StatelessWidget {
  final double goalCal;
  final double dailyCal;
  final double burnedCal;

  MacrosCard(
      {Key? key,
      this.goalCal = 2000,
      required this.dailyCal,
      this.burnedCal = 0})
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

class MacrosCardWithData extends StatelessWidget {
  final String userId;

  MacrosCardWithData({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: fetchUserDataStream(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return MacrosCard(
              goalCal: snapshot.data!['goalcals'].toDouble(),
              dailyCal: snapshot.data!['calories'].toDouble(),
              burnedCal: 0, // You can update this as needed
            );
          } else {
            return Text('Error fetching data.');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
