import 'package:flutter/material.dart';
import 'package:zeppos/CardForHome.dart';
import 'package:zeppos/bottomNavBar.dart';
import 'package:zeppos/mealPlans.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: LayoutBuilder(
          // <-- Use LayoutBuilder here
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    // Provide constraints to the content
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      children: <Widget>[
                        macrosCard(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Food Log",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text("Food"),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Calories"),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Carbs"),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Protein"),
                              SizedBox(
                                width: 60,
                              ),
                              Text("Fat"),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: bottomNavBar(),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: macrosCard(),
                ),
                Center(
                  child: Text("thing"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
