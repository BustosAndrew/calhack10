import 'package:flutter/material.dart';
import 'package:zeppos/CardForHome.dart';
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
        body: const SingleChildScrollView(
          child: Column(
            children: [
              macrosCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [NutritionalFactCard()],
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.blue,
          height: 30,
        ),
      ),
    );
  }
}
