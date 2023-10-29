import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeppos/CardForHome.dart';
import 'package:zeppos/bottomNavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId == null) {
      return Center(child: Text('User is not logged in!'));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            // Static Content
            Container(
              child: MacrosCardWithData(userId: userId),
            ),

            const SizedBox(height: 10),
            const Text(
              "Food Log",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text("Food"),
                  Text("Calories"),
                  Text("Carbs"),
                  Text("Protein"),
                  Text("Fat"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Scrollable Content
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('dailyMacros')
                    .orderBy('date', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // If no documents are returned, show a message
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No foods logged for today.'));
                  }

                  // Correcting type cast here
                  final foodIds = (snapshot.data!.docs[0]['foods'] as List)
                      .map((item) => item.toString())
                      .toList();

                  return FutureBuilder<List<DocumentSnapshot>>(
                    future: _fetchFoodsByIds(foodIds),
                    builder: (context, foodSnapshot) {
                      if (!foodSnapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final foods = foodSnapshot.data!;

                      return ListView.builder(
                        itemCount: foods.length,
                        itemBuilder: (BuildContext context, int index) {
                          final food = foods[index];

                          final foodName = food['name'];
                          final calories = food['calories'];
                          final carbs = food['carbs'];
                          final protein = food['protein'];
                          final fat = food['fat'];

                          return ListTile(
                            title: Text(foodName),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('$calories'),
                                Text('${carbs}g'),
                                Text('${protein}g'),
                                Text('${fat}g'),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Assuming you have a function called bottomNavBar() that returns a widget
            bottomNavBar(),
          ],
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchFoodsByIds(List<String> foodIds) async {
    final firestore = FirebaseFirestore.instance;
    List<DocumentSnapshot> foodsList = [];

    for (String id in foodIds) {
      final foodDoc = await firestore.collection('foods').doc(id).get();
      foodsList.add(foodDoc);
    }

    return foodsList;
  }
}
