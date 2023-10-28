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
                      children: [
                        macrosCard(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //NutritionalFactCard()
                          ],
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
              ],
            );
          },
        ),
      ),
    );
  }
}
