import 'package:flutter/material.dart';
import 'package:zeppos/CardForHome.dart';
import 'package:zeppos/bottomNavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            // Static Content
            Container(
              child: MacrosCard(),
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
              child: ListView.builder(
                itemCount: 2, // adjust this number based on your data size
                itemBuilder: (BuildContext context, int index) {
                  // Return a widget that displays the food data
                  // For demonstration purposes, I'm using dummy data.
                  return ListTile(
                    title: Text('Name $index'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${index * 100}'),
                        Text('${index * 10}g'),
                        Text('${index * 15}g'),
                        Text('${index * 5}g'),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bottom Nav Bar
            bottomNavBar(),
          ],
        ),
      ),
    );
  }
}
