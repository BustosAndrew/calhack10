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
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bar_chart)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.message_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.apple))
            ],
          ),
        ),
      ),
    );
  }
}
